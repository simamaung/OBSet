unit Unit2;

interface

uses classes, sysutils;

type

TObset=packed record
  text:ansistring;
  filename:ansistring;
  tpe:byte;
  interval,tmp:real;
  index:integer;
  format:ansistring;
  status:byte;
end;

TOBSets=class
private
  f:TList;
public
  constructor Create;
  destructor Destroy;override;
  function GetSet(index:integer):TOBSet;
  procedure SetSet(index:integer;v:TObset);
  function Add_set(filename:ansistring;tipe:byte;interval:real;format:ansistring;status:boolean):integer;overload;
  function Add_set(obset:TObset):integer;overload;
  procedure Delete_set(index:integer);
  procedure Delete_text(index_set,index_text:integer);
  procedure Clear_set;
  procedure Clear_text(index_set:integer);
  procedure SaveToFile(filename:string);
  procedure LoadFromFile(filename:string);
  function get_text(index_set,index_text:integer):ansistring;
  function get_type(index_set:integer):byte; 
  function get_Interval(index_set:integer):real; 
  function get_format(index:integer):ansistring;
  function get_status(index:integer):boolean;
  procedure add_text(index_set:integer;a:ansistring);
  procedure set_text(index_set,index_text:integer;a:ansistring);
  procedure set_filename(index:integer;filename:ansistring);
  procedure set_tipe(index:integer;tipe:byte);
  procedure set_interval(index:integer;v:real);
  procedure set_format(index:integer;format:ansistring);
  procedure set_status(index:integer;status:boolean);
  function counter:integer;
end;

implementation

function TOBSets.counter:integer;
begin
  result:=f.Count;
end;
constructor TOBSets.Create;
begin
  inherited Create;
  f:=TList.Create;
end;
destructor TOBSets.Destroy;
begin
  f.Clear;
  f.Free;
  inherited Destroy;
end;
function TOBSets.Add_set(filename:ansistring;tipe:byte;interval:real;format:ansistring;status:boolean):integer;
var a:^TObset;
begin
  new(a);
  a^.filename:=filename;
  a^.tpe:=tipe;
  a^.interval:=interval;
  a^.text:='';
  a^.format:=format;
  a^.tmp:=0;
  a^.index:=-1;
  if status then a^.status:=1 else a^.status:=0;
  result:=f.Add(a);
end;
function TOBSets.Add_set(obset:TObset):integer;
var a:^TObset;
begin
  new(a);
  a^:=obset;
  result:=f.Add(a);
end;
function TOBSets.GetSet(index:integer):TOBSet;
var a:^TObset;
begin
  a:=F[index];
  result:=a^;
end;
procedure TOBSets.SetSet(index:integer;v:TObset);
var a:^TObset;
begin
  a:=F[index];
  a^:=v;
  f[index]:=a;
end;
procedure TOBSets.Add_text(index_set:integer;a:ansistring);
var r:TObset;
    s:TStringlist;
begin
  s:=TStringlist.Create;
  try
    r:=getset(index_set);
    s.Text:=r.text;
    s.Add(a);
    r.text:=s.Text;
    setset(index_set,r);
  finally
    s.Free;
  end;
end;
procedure TOBSets.Delete_set(index:integer);
begin
  f.Delete(index);
end;
procedure TOBSets.Delete_text(index_set,index_text:integer);
var r:TObset;
    s:Tstringlist;
begin
  s:=Tstringlist.Create;
  try
    r:=getset(index_set);
    s.Text:=r.text;
    s.Delete(index_set);
    r.text:=s.Text;
    setset(index_set,r);
  finally
    s.Free;
  end;
end;
procedure TOBSets.Clear_set;
begin
  f.Clear;
end;
procedure TOBSets.Clear_text(index_set:integer);
var r:TObset;
begin
  r:=getset(index_set);
  r.text:='';
  setset(index_set,r);
end;
procedure TOBSets.savetofile(filename:string);
var i,j,n:integer;
    r:TObset;
    t:TFileStream;
    s:ansistring;
begin
  t:=TFileStream.Create(filename,fmcreate or fmopenwrite);
  try
    j:=123;
    t.WriteBuffer(j,4);
    j:=f.Count;
    t.WriteBuffer(j,4);
    for i:=0 to j-1 do begin               
      r:=getset(i);
      t.WriteBuffer(r.tpe,1);
      t.WriteBuffer(r.interval,8);
      t.WriteBuffer(r.status,1);

      n:=length(r.filename);
      t.WriteBuffer(n,4);
      setlength(s,n);
      s:=r.filename;
      t.WriteBuffer(s[1],n);

      n:=length(r.text);
      t.WriteBuffer(n,4);
      setlength(s,n);
      s:=r.text;
      t.WriteBuffer(s[1],n);

      n:=length(r.format);
      t.WriteBuffer(n,4);
      setlength(s,n);
      s:=r.format;
      t.WriteBuffer(s[1],n);           
    end;
  finally
    t.Free;
  end;
end;
procedure TOBSets.LoadFromFile(filename:string);
var i,j,n:integer;
    r:TObset;
    t:TFileStream;
    s:ansistring;
begin
  t:=TFileStream.Create(filename,fmopenread or fmsharedenynone);
  try
    t.ReadBuffer(j,4);
    if(j<>123)then exit;
    t.ReadBuffer(j,4);
    for i:=0 to j-1 do begin
      t.ReadBuffer(r.tpe,1);
      t.ReadBuffer(r.interval,8);
      t.ReadBuffer(r.status,1);

      t.ReadBuffer(n,4);
      setlength(s,n);
      t.ReadBuffer(s[1],n);
      r.filename:=s;
      
      t.ReadBuffer(n,4);
      setlength(s,n);
      t.ReadBuffer(s[1],n);
      r.text:=s;

      t.ReadBuffer(n,4);
      setlength(s,n);
      t.ReadBuffer(s[1],n);
      r.format:=s;

      r.tmp:=now;
      r.index:=0;
      add_set(r);      
    end;
  finally
    t.Free;
  end;
end;

function TOBSets.get_text(index_set,index_text:integer):ansistring;
var r:TOBSet;
    s:TStringlist;
begin
  if index_text<0 then exit;
  if index_set<0 then exit;
  
  r:=getset(index_set);
  s:=TStringlist.Create;
  try
    s.Text:=r.text;
    result:=s[index_text];
  finally
    s.Free;
  end;
end;
function TOBSets.get_type(index_set:integer):byte;
var r:TObset; 
begin
  r:=getset(index_set);
  result:=r.tpe;
end;
function TOBSets.get_Interval(index_set:integer):real;
var r:TObset; 
begin
  r:=getset(index_set);
  result:=r.interval;
end;
function TOBSets.get_format(index: Integer):ansistring;
var r:TOBSet;
begin
  r:=getset(index);
  result:=r.format;
end;
function TOBsets.get_status(index: Integer):boolean;
var r:TOBSet;
begin
  r:=getset(index);
  result:=r.status=1;
end;
procedure TOBSets.set_text(index_set: Integer; index_text: Integer; a: AnsiString);
var r:TOBSet;
    s:Tstringlist;
begin
  r:=getset(index_set);
  s:=Tstringlist.Create;
  try
    s.Text:=r.text;
    s[index_text]:=a;
    r.text:=s.Text;
    setset(index_set,r);
  finally
    s.Free;
  end;
end;
procedure TOBSets.set_filename(index: Integer; filename: AnsiString);
var r:TOBSet;
begin
  r:=getset(index);
  r.filename:=filename;
  setset(index,r);
end;
procedure TOBSets.set_tipe(index: Integer; tipe: Byte);
var r:TOBSet;
begin
  r:=getset(index);
  r.tpe:=tipe;
  setset(index,r);
end;
procedure TOBSets.set_interval(index: Integer; v: Real);
var r:TOBSet;
begin
  r:=getset(index);
  r.interval:=v;
  setset(index,r);
end;
procedure TOBSets.set_format(index: Integer; format: AnsiString);
var r:TOBSet;
begin
  r:=getset(index);
  r.format:=format;
  setset(index,r);
end;
procedure TOBSets.set_status(index: Integer; status: Boolean);
var r:TOBSet;
begin
  r:=getset(index);
  if status then r.status:=1 else r.status:=0;
  setset(index,r);
end;

end.
