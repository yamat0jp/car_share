unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    DSProviderConnection1: TDSProviderConnection;
    StringGrid1: TStringGrid;
  private
    { private êÈåæ }
  public
    { public êÈåæ }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
