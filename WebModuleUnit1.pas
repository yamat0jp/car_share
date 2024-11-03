unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Web.DBWeb, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Web.HTTPProd;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    DataSetTableProducer1: TDataSetTableProducer;
    PageProducer1: TPageProducer;
    FDTable2: TFDTable;
    FDTable2GROUP: TIntegerField;
    FDTable2CARID: TIntegerField;
    FDTable2CATEGORY: TWideStringField;
    FDTable2CARNUMBER: TWideStringField;
    FDTable1ID: TIntegerField;
    FDTable1CARID: TIntegerField;
    FDTable1DATE: TSQLTimeStampField;
    FDTable1MATERSTART: TIntegerField;
    FDTable1MATERSTOP: TIntegerField;
    FDTable1CODENAME: TIntegerField;
    FDTable1CUSTOM: TWideStringField;
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure DataSetTableProducer1FormatCell(Sender: TObject;
      CellRow, CellColumn: Integer; var BgColor: THTMLBgColor;
      var Align: THTMLAlign; var VAlign: THTMLVAlign;
      var CustomAttrs, CellData: string);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { private êÈåæ }
    tmpstr, CookieItem: string;
  public
    { public êÈåæ }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.NetEncoding;

procedure TWebModule1.DataSetTableProducer1FormatCell(Sender: TObject;
  CellRow, CellColumn: Integer; var BgColor: THTMLBgColor;
  var Align: THTMLAlign; var VAlign: THTMLVAlign;
  var CustomAttrs, CellData: string);
var
  i: Integer;
begin
  case CellColumn of
    3:
      if CellRow = 0 then
        CellData := 'DISTANCE'
      else
      begin
        with FDTable1 do
          i := FieldByName('MATER STOP').AsInteger - FieldByName('MATER START')
            .AsInteger;
        CellData := i.ToString;
      end;
    4:
      begin
        CustomAttrs := 'hidden=true';
        tmpstr := CellData;
      end;
    5:
      if CookieItem = tmpstr then
        CellData := Format('<input name="%d" value="%s">',
          [CellRow, FDTable1.FieldByName('custom').AsString]);
  end;
end;

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  int: Integer;
  str: string;
begin
  ReplaceText := '<select name="car number"><option>ëIëÇµÇƒÇ≠ÇæÇ≥Ç¢</option>';
  FDTable2.First;
  while not FDTable2.Eof do
  begin
    int := FDTable2.FieldByName('car id').AsInteger;
    str := FDTable2.FieldByName('car number').AsString;
    ReplaceText := ReplaceText + Format('<option value="%d">%s</option>',
      [int, str]);
    FDTable2.Next;
  end;
  ReplaceText := ReplaceText + '</select>';
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  number: string;
  id: Integer;
begin
  CookieItem := TNetEncoding.URL.Decode(Request.CookieFields.Values['name']);
  number := TNetEncoding.URL.Decode(Request.CookieFields.Values['number']);
  if TryStrToInt(number, id) then
  begin
    FDTable1.Filter := '"CAR ID" = ' + number;
    FDTable1.First;
    number := FDTable2.Lookup('car id', id, 'car number');
    DataSetTableProducer1.Header.Text :=
      Format('<p>é‘óºÉiÉìÉoÅ[Åy%sÅz</p><form action="/post" method=post>', [number]);
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := DataSetTableProducer1.Content;
  end
  else
    Response.SendRedirect('/select');
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  list: TStringList;
begin
  if Request.MethodType = mtPost then
  begin
    list := TStringList.Create;
    try
      list.Add('name=1'); // + Request.ContentFields.Values['code name']);
      list.Add('number=' + Request.ContentFields.Values['car number']);
      Response.SetCookieField(list, 'localhost', '/', Now + 30, false);
    finally
      list.Free;
    end;
    Response.SendRedirect('/');// Handled:=false don't fit
  end
  else
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := PageProducer1.Content;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  key, value: string;
  id: Integer;
begin
  for var i := 0 to Request.ContentFields.Count - 1 do
  begin
    key := Request.ContentFields.KeyNames[i];
    if TryStrToInt(key, id) then
      with FDTable1 do
      begin
        value := Request.ContentFields.Values[key];
        RecNo := id;
        if FieldByName('custom').AsString <> value then
        begin
          Edit;
          FieldByName('custom').AsString := value;
          Post;
        end;
      end;
  end;
  Handled := false;
end;

end.
