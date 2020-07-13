<template>
    <div id="test" :style="CSS_VARS">
        <div :class="['progress']"
             @mousemove="prgOver($event)"
             @mouseout="prgOut()"
             @click="prgClick($event)">
            <div :class="['played',mouse.isHover?'hover-played':'']"></div>
            <div :class="['playing']"></div>
            <i class="slash"
               :style="{'left':(_getDataPercent() * (index + 1) - 2 + 'px')}"
               v-for="(o,index) in data"
               :key="o">
                <i style="display: none">{{o}}</i>
            </i>
            <div class="hover-tip"></div>
            <div class="const-tip"></div>
        </div>
    </div>
</template>

<script>
    let timer;
    const delay = (ms = 100) => {
        if (timer) clearTimeout(timer);
        return new Promise(resolve => {
            setTimeout(() => {
                resolve()
            }, ms)
        })
    }

    const toPx = (unit) => {
        return [unit, 'px'].join('')
    }
    const d = (className) => {
        return document.getElementsByClassName(className)[0]
    }
    const dR = (dom) => {
        return dom.getClientRects()[0];
    }

    export default {
        props: {},
        data() {
            return {
                styles: {
                    w: 0,
                    h: 0,
                    progress: {
                        w: .6,
                        h: 90
                    },
                    played: {
                        w: 0
                    },
                    playing: {
                        w: 0
                    }
                },
                rect: null,
                mouse: {
                    x: 0,
                    index: 0,
                    isHover: false,
                },
                data: [
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                ]
            }
        },
        async mounted() {
            await this.$nextTick();
            const $progress = d('progress');
            this.styles.w = document.body.offsetWidth;
            this.rect = dR($progress)
            document.body.onresize = () => {
                this.rect = dR($progress);
                this.styles.w = document.body.offsetWidth;
            }

            document.body.onmousemove = () => {
                if (!this.mouse.isHover) this._setPlayed(0)
            }
        },
        computed: {
            CSS_VARS() {
                let _pw = this.styles.w * this.styles.progress.w
                return {
                    "--progress-width": toPx(_pw),
                    "--played-width": toPx(_pw * this.styles.played.w),
                    "--playing-width": toPx(_pw * this.styles.playing.w)
                }
            },
            dataLen() {
                return this.data.length;
            }
        },
        methods: {
            prgClick(e) {
                this.mouse.x = e.pageX - this.rect.left
                this._setPlaying(this._getPercent(this.mouse.x))
                this._setPlaying(this._getPercent(this._getDataPercent() * (this.mouse.index + 1)))
                this.mouse.index++
                if (this.mouse.index + 1 > this.dataLen) {
                    this.mouse.index = -1
                }
            },
            async prgOver(e) {
                this.mouse.isHover = true;
                await delay(220)
                this._setPlayed(this._getPercent(e.pageX - this.rect.left))
            },
            async prgOut() {
                await delay(300)
                this.mouse.isHover = false;
            },
            _setPlayed(x) {
                this.styles.played.w = x
            },
            _setPlaying(x) {
                this.styles.playing.w = x
            },
            _getPercent(x) {
                return x / parseFloat(this.CSS_VARS["--progress-width"])
            },
            _getDataPercent() {
                return parseFloat(this.CSS_VARS["--progress-width"]) / this.dataLen
            }
        },
        destroyed() {
            document.body.onresize = null;
            document.body.onmousemove = null
        }
    };
</script>

<style scoped lang="scss">
    #test {
        position: absolute;
        bottom: 60px;

        .progress {
            position: relative;
            left: 60px;
            margin: 10px;
            width: var(--progress-width);
            min-height: 10px;
            border-radius: 90px;
            background-color: rgba(255, 160, 122, 0.85);
            transition: width ease-in-out .5s;

            .played {
                position: absolute;
                top: 0;
                height: 10px;
                border-radius: 90px;
                width: var(--played-width);
                background-color: rgba(255, 228, 196, 0.75);
                transition: width linear .2s, background-color linear .5s;

                &.hover-played {
                    background-color: rgba(255, 255, 255, 0.65) !important;
                }
            }

            .playing {
                height: 10px;
                border-radius: inherit;
                width: var(--playing-width);
                background-color: rgba(255, 255, 255, 0.95);
                transition: width linear .3s, background-color linear .3s;
            }

            .slash {
                position: absolute;
                top: .5px;
                display: block;
                content: ' ';
                width: 2px;
                height: 8px;
                background-color: rgba(66, 66, 69, 0.65);
                color: transparent;
                border-radius: 10px;
                transition: width linear .2s, left linear .6s;
            }
        }
    }
</style>