using Godot;
using System;
using System.Collections.Generic;
using FFMpegCore;
using FFMpegCore.Arguments;


public partial class GifConverter : Control {
  private readonly List<string> _exts = new() {
    "gif"
  };

  private FileDialog dlgFile;
  private Button btnOpenFile;

  private string folderPath;

  public override void _Ready() {
    dlgFile = GetNode<FileDialog>("%file_dialog");
    btnOpenFile = GetNode<Button>("%open_file");

    btnOpenFile.Pressed += onBtnOpenFileClick;
    dlgFile.DirSelected += onDlgFileSelected;
  }

  public override void _Process(double delta) {
  }

  private void onDlgFileSelected(string dir) {
    folderPath = dir;
    var files = DirAccess.Open(dir).GetFiles();
    foreach (var file in files) {
      var ex = file.GetExtension();

      if (_exts.Contains(ex)) {
        continue;
      }

      var inputPath = $"{dir}\\{file}";
      var outputFile = file.Replace(ex, "gif");
      var outputPath = $"{dir}\\{outputFile}";
      Console.WriteLine(outputPath);


      FFMpegArguments
              .FromFileInput(inputPath)
              .OutputToFile(outputPath,
                      false,
                      options => options
                              .ForceFormat("gif")
                              .WithFrameOutputCount(60)
              ).ProcessSynchronously();
    }
  }

  private void onBtnOpenFileClick() {
    dlgFile.Visible = true;
  }
}
