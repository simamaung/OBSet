object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'OBSet'
  ClientHeight = 392
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object TabControl1: TTabControl
    Left = 0
    Top = 41
    Width = 402
    Height = 332
    Align = alClient
    MultiLine = True
    TabOrder = 0
    OnChange = TabControl1Change
    object PageControl1: TPageControl
      Left = 4
      Top = 75
      Width = 394
      Height = 253
      ActivePage = TabSheet3
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Date Time'
        TabVisible = False
        object Memo1: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 52
          Width = 380
          Height = 188
          Align = alClient
          BorderStyle = bsNone
          Lines.Strings = (
            'y '#9'= Year last 2 digits'
            'yy '#9'= Year last 2 digits'
            'yyyy '#9'= Year as 4 digits'
            'm '#9'= Month number no-leading 0'
            'mm '#9'= Month number as 2 digits'
            'mmm '#9'= Month using ShortDayNames (Jan)'
            'mmmm '#9'= Month using LongDayNames (January)'
            'd '#9'= Day number no-leading 0'
            'dd '#9'= Day number as 2 digits'
            'ddd '#9'= Day using ShortDayNames (Sun)'
            'dddd '#9'= Day using LongDayNames  (Sunday)'
            'ddddd '#9'= Day in ShortDateFormat'
            'dddddd '#9'= Day in LongDateFormat'
            ' '#9
            'c '#9'= Use ShortDateFormat + LongTimeFormat'
            'h '#9'= Hour number no-leading 0'
            'hh '#9'= Hour number as 2 digits'
            'n'#9'= Minute number no-leading 0'
            'nn '#9'= Minute number as 2 digits'
            's '#9'= Second number no-leading 0'
            'ss '#9'= Second number as 2 digits'
            'z'#9'= Milli-sec number no-leading 0s'
            'zzz '#9'= Milli-sec number as 3 digits'
            't '#9'= Use ShortTimeFormat'
            'tt '#9'= Use LongTimeFormat'
            ' '#9
            'am/pm '#9'= Use after h : gives 12 hours + am/pm'
            'a/p '#9'= Use after h : gives 12 hours + a/p'
            'ampm '#9'= As a/p but TimeAMString,TimePMString'
            '/ '#9'= Substituted by DateSeparator value'
            ':'#9'= Substituted by TimeSeparator value')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 49
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Label2: TLabel
            Left = 8
            Top = 17
            Width = 46
            Height = 16
            Caption = 'Format:'
          end
          object Edit2: TEdit
            Left = 60
            Top = 14
            Width = 313
            Height = 24
            TabOrder = 0
            OnChange = Edit2Change
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Multi Text'
        ImageIndex = 1
        TabVisible = False
        object ListBox1: TListBox
          Left = 0
          Top = 49
          Width = 386
          Height = 194
          Align = alClient
          TabOrder = 0
          OnClick = ListBox1Click
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 49
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Label5: TLabel
            Left = 8
            Top = 16
            Width = 25
            Height = 16
            Caption = 'Text'
          end
          object Edit3: TEdit
            Left = 60
            Top = 13
            Width = 246
            Height = 24
            TabOrder = 0
          end
          object Button3: TButton
            Left = 312
            Top = 13
            Width = 61
            Height = 24
            Caption = 'Save'
            TabOrder = 1
            OnClick = Button3Click
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'counter'
        ImageIndex = 2
        TabVisible = False
        object Button5: TButton
          Left = 48
          Top = 112
          Width = 75
          Height = 25
          Caption = 'Reset'
          TabOrder = 0
          OnClick = Button5Click
        end
      end
    end
    object Panel2: TPanel
      Left = 4
      Top = 6
      Width = 394
      Height = 69
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 12
        Top = 8
        Width = 38
        Height = 16
        Caption = 'Target'
      end
      object Label4: TLabel
        Left = 12
        Top = 38
        Width = 28
        Height = 16
        Caption = 'Type'
      end
      object Label3: TLabel
        Left = 164
        Top = 39
        Width = 48
        Height = 16
        Caption = 'Interval:'
      end
      object Edit1: TEdit
        Left = 64
        Top = 5
        Width = 284
        Height = 24
        TabOrder = 0
        OnChange = Edit1Change
      end
      object Button2: TButton
        Left = 354
        Top = 5
        Width = 23
        Height = 25
        Caption = '...'
        TabOrder = 1
        OnClick = Button2Click
      end
      object CheckBox1: TCheckBox
        Left = 320
        Top = 39
        Width = 57
        Height = 17
        Caption = 'Enable'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object ComboBox1: TComboBox
        Left = 64
        Top = 35
        Width = 89
        Height = 24
        TabOrder = 3
        Text = 'Date Time'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Date Time'
          'Multi Text'
          'Counter')
      end
      object DateTimePicker1: TDateTimePicker
        Left = 218
        Top = 36
        Width = 89
        Height = 24
        Date = 44221.000000000000000000
        Format = 'HH:mm:ss'
        Time = 0.000694444446708076
        Kind = dtkTime
        TabOrder = 4
        OnChange = DateTimePicker1Change
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 402
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      402
      41)
    object Button1: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 318
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Delete'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 373
    Width = 402
    Height = 19
    Panels = <>
  end
  object OpenDialog1: TOpenDialog
    Left = 292
    Top = 239
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 216
    Top = 242
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    Left = 304
    Top = 186
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 194
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
end
