unit Unit1;

interface

uses
  unit2,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Menus;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    Panel1: TPanel;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    Panel3: TPanel;
    Edit3: TEdit;
    Label5: TLabel;
    Button3: TButton;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    StatusBar1: TStatusBar;
    Button4: TButton;
    Memo1: TMemo;
    Panel4: TPanel;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    TabSheet3: TTabSheet;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    o:TObsets;
    fn:string;
    cl:boolean;
    str:real;
    procedure list_text;
    procedure obstotabcontrol;
    procedure applyobspagecontrol;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure ShowTaskBarClick(show:boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ShowTaskBarClick(show:boolean);
var hTaskBar : THandle;
begin
  //hTaskbar := FindWindow('Shell_TrayWnd', Nil);
  //if show then ShowWindow(hTaskBar, SW_SHOWNORMAL) else ShowWindow(hTaskBar, SW_HIDE)
end;

procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_APPWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then
    ShowWindow(Handle, SW_MINIMIZE)
  else
    inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
  i:=tabcontrol1.Tabs.Count;
  tabcontrol1.Tabs.Add('OBSet #'+(i+1).tostring);
  o.Add_set('',0,0,'',true);
  o.SaveToFile(fn);
  obstotabcontrol;
end;

procedure TForm1.Button2Click(Sender: TObject);
var r:TOBSet;
begin
  opendialog1.Filter:='ASCII|*.txt|ALL|*.*';
  opendialog1.FileName:=edit1.Text;
  if opendialog1.Execute then begin
    edit1.Text:=opendialog1.FileName;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if listbox1.ItemIndex<0 then begin
    o.add_text(tabcontrol1.TabIndex,edit3.Text)
  end else
  o.set_text(tabcontrol1.TabIndex,listbox1.ItemIndex,edit3.Text);
  o.SaveToFile(fn);
  listbox1.Items.Text:=o.GetSet(tabcontrol1.TabIndex).text;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if o.counter>0 then begin
    o.Delete_set(tabcontrol1.TabIndex);
    o.SaveToFile(fn);
  end;
  obstotabcontrol;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  str:=-1;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if TabControl1.TabIndex<0 then exit;
  o.set_status(tabcontrol1.TabIndex,checkbox1.Checked);
  o.SaveToFile(fn);
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  cl:=true;
  close;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if TabControl1.TabIndex<0 then exit;
  o.set_tipe(tabcontrol1.TabIndex,ComboBox1.ItemIndex);
  o.SaveToFile(fn);
  pagecontrol1.ActivePageIndex:=ComboBox1.ItemIndex;
end;

procedure TForm1.DateTimePicker1Change(Sender: TObject);
begin
  if TabControl1.TabIndex<0 then exit;
  o.set_interval(tabcontrol1.TabIndex,DateTimePicker1.Time);
  o.SaveToFile(fn);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if TabControl1.TabIndex<0 then exit;
  o.set_filename(tabcontrol1.TabIndex,edit1.Text);
  o.SaveToFile(fn);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  if TabControl1.TabIndex<0 then exit;
  o.set_format(tabcontrol1.TabIndex,edit2.Text);
  o.SaveToFile(fn);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {if cl then begin
    action:=cafree;
  end else begin
    action:=canone;
    ShowWindow(Handle, SW_MINIMIZE);
  end;{}
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  ShowTaskBarClick(false);
  cl:=false;
  o:=TObsets.Create;
  fn:=extractfilepath(paramstr(0))+'config.obset';
  if fileexists(fn) then o.LoadFromFile(fn);

  for i:=0 to pagecontrol1.PageCount-1 do pagecontrol1.Pages[i].TabVisible:=false;
  obstotabcontrol;
       {
  tabcontrol1.Visible:=false;
  panel1.Visible:=false;
  color:=clblack;  {}
end;

procedure TForm1.obstotabcontrol;
var i:integer;
begin
  tabcontrol1.Tabs.Clear;       
  if o.counter>0 then begin
    for i:=0 to o.counter-1 do
    tabcontrol1.Tabs.Add('OBSet #'+(i+1).ToString);   {}
    panel2.Visible:=true;
    pagecontrol1.Visible:=true;
  end else begin
    panel2.Visible:=false;
    pagecontrol1.Visible:=false;
  end;
  applyobspagecontrol;
end;
procedure TForm1.FormDestroy(Sender: TObject);
begin
  o.Destroy;
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin
  applyobspagecontrol;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
    r:TOBSet;
    s,a:TStringlist;
    n:real;
    h,m,d,ms:word;
begin
  timer1.Enabled:=false;
  s:=TStringlist.Create;
  a:=TStringlist.Create;
  n:=now;
  try
    for i:=0 to o.counter-1 do begin
      r:=o.GetSet(i);
      if fileexists(r.filename) then begin
        if (r.status=1)and(r.interval>0) then begin
          if r.tpe=0 then begin // datetime
            if n-r.tmp>=r.interval then begin
              s.Text:=formatdatetime(r.format,now);
              s.SaveToFile(r.filename);
              r.tmp:=n;
              o.SetSet(i,r);
            end;
          end else if r.tpe=1 then begin // multitext
            if n-r.tmp>=r.interval then begin
              a.Text:=r.text;
              r.index:=r.index mod a.Count;
              if a.Count>0 then begin
                if (r.index>=0)and(r.index<a.Count) then begin
                  s.Text:=a[r.index];
                  s.SaveToFile(r.filename);
                end;
                r.index:=(r.index+1)mod a.Count;
              end;
              r.tmp:=n;
              o.SetSet(i,r);
            end;
          end else begin
            //decodetime(now-str,h,m,d,ms);
            //s.Text:=format('%d:%d:%d:%d',[h,m,d,ms]);
            //s.SaveToFile(r.filename);
          end;
        end;
      end;
    end;
  finally
    s.Free;
    a.Free;
  end;
  timer1.Enabled:=true;
end;

procedure TForm1.applyobspagecontrol;
var r:TOBSet;
begin
  if TabControl1.TabIndex<0 then exit;
  if o.counter=0 then exit;  
  r:=o.GetSet(TabControl1.TabIndex);
  pagecontrol1.ActivePageIndex:=r.tpe;
  edit1.Text:=r.filename;
  edit2.Text:=r.format;
  list_text;
  checkbox1.Checked:=r.status=1;
  datetimepicker1.Time:=r.interval;
  combobox1.ItemIndex:=r.tpe;
end;

procedure TFOrm1.list_text;
var r:TOBSet;
begin
  if TabControl1.TabIndex<0 then exit;
  r:=o.GetSet(tabcontrol1.TabIndex);
  listbox1.Items.Text:=r.text;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  edit3.Text:=ListBox1.Items[ListBox1.ItemIndex];
end;

end.
