<template>
    <div id="test" :style="CSS_VARS">
        <div :class="['progress']"
             @mousemove="prgOver($event)"
             @mouseout="prgOut()"
             @click="prgClick($event)">
            <div :class="['played',mouse.isHover?'hover-played':'']"></div>
            <div :class="['playing']"></div>
            <div class="hover-tip"></div>
            <div class="const-tip"></div>
        </div>
        {{mouse.isHover}}
    </div>
</template>

<script>
    import {delay} from "../../../utils/common";

    const toPx = (unit) => {
        return [unit, 'px'].join('')
    }

    const dR = (className) => {
        return document.getElementsByClassName(className)[0].getClientRects()[0];
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
                    index:0,
                    isHover: false,
                },
                data:[
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
            this.styles.w = document.body.offsetWidth;
            this.rect = dR('progress')
            document.body.onresize = () => {
                this.rect = dR('progress');
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
            }
        },
        methods: {
            prgClick(e) {
                this.mouse.x = e.pageX - this.rect.left
                this._setPlaying(this._getPercent(this.mouse.x))
            },
            async prgOver(e) {
                this.mouse.isHover = true;
                await delay(100)
                this._setPlayed(this._getPercent(e.pageX - this.rect.left))
            },
            prgOut() {
                console.log('out')
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
        },
        destroyed() {
            document.body.onresize = null;
        }
    };
</script>

<style scoped lang="scss">
    #test {
        position: absolute;
        bottom: 0;

        .progress {
            position: relative;
            left: 300px;
            margin: 10px;
            width: var(--progress-width);
            min-height: 10px;
            border-radius: 90px;
            background-color: rgba(255, 160, 122, 0.85);
            transition: width ease-in-out .2s;

            .played {
                position: absolute;
                top: 0;
                height: 10px;
                border-radius: 90px;
                width: var(--played-width);
                background-color: rgba(255, 228, 196, 0.75);
                transition: width linear .2s, background-color linear .5s;

                &.hover-played {
                    background-color: rgba(255, 228, 196, 0.35);
                }
            }

            .playing {
                height: 10px;
                border-radius: inherit;
                width: var(--playing-width);
                background-color: rgba(206, 160, 106, 0.95) !important;
                transition: width linear .2s, background-color linear .5s;
            }
        }
    }
</style>