{ //************************************************************// }
{ //                                                            // }
{ //         C�digo gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 03/03/2017 11:35:23                                  // }
{ //************************************************************// }
/// <summary>
/// Uma View representa a camada de apresenta��o ao usu�rio
/// deve esta associado a um controller onde ocorrer�
/// a troca de informa��es e comunica��o com os Models
/// </summary>
unit WSConfigView;

interface

uses
{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}
  System.SysUtils, System.Classes, MVCBr.Interf,
  MVCBr.ObjectConfigList, MVCBr.View,
  System.JSON,
  MVCBr.FormView, MVCBr.Controller,
  VCL.Controls, VCL.StdCtrls;

type
  TWSConfigView = class;

  /// Interface para a VIEW
  IWSConfigView = interface(IView)
    ['{3DCAFC16-0A94-403F-8EAA-F328F6588A66}']
    // incluir especializacoes aqui
    function ThisAs: TWSConfigView;
    function GetConfig: TJsonValue;
    function GetServer: TJsonValue;
    function ConnectionString: string;
    function GetPort: integer;
  end;

  /// Object Factory que implementa a interface da VIEW
  TWSConfigView = class(TFormFactory { TFORM } , IView, IThisAs<TWSConfigView>,
    IWSConfigView, IViewAs<IWSConfigView>)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    driverid: TComboBox;
    Label2: TLabel;
    Server: TEdit;
    Label3: TLabel;
    Database: TEdit;
    Label4: TLabel;
    user_name: TEdit;
    Label5: TLabel;
    Password: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    WSPort: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  protected
    FList: IObjectConfigList;
    procedure AddControls;
    function Controller(const aController: IController): IView; override;
  public
    { Public declarations }
    class function New(aController: IController): IView;
    function This: TObject; override;
    function ThisAs: TWSConfigView;
    function ViewAs: IWSConfigView;
    function ShowView(const AProc: TProc<IView>): integer; override;
    function Update: IView; override;
    function GetConfig: TJsonValue;
    function GetServer: TJsonValue;
    function ConnectionString: string;
    function GetPort: integer;
  end;

Implementation

{$R *.DFM}

uses System.JSON.helper;

function TWSConfigView.Update: IView;
begin
  result := self;
  { codigo para atualizar a View vai aqui... }
end;

function TWSConfigView.ViewAs: IWSConfigView;
begin
  result := self;
end;

procedure TWSConfigView.FormCreate(Sender: TObject);
begin
  FList := TObjectConfigModel.New;
  FList.FileName := ExtractFilePath(ParamStr(0)) + 'MVCBrServer.config';
  AddControls;
  try
    if not fileExists(FList.FileName) then
      FList.WriteConfig;
  except
  end;
  FList.ReadConfig;
end;

function TWSConfigView.GetConfig: TJsonValue;
var
  j: TJsonObject;
begin
  j := TJsonObject.create() as TJsonObject;
  j.addPair('connection', GetServer);
end;

function TWSConfigView.GetPort: integer;
begin
  result := strToIntDef(WSPort.Text, 8080);
end;

function TWSConfigView.GetServer: TJsonValue;
begin
  result := TJsonObject.create();
  result.addPair('driverid', DriverID.Text);
  result.addPair('server', Server.Text);
  result.addPair('database', Database.Text);
  result.addPair('user_name', User_Name.Text);
  result.addPair('password', Password.Text);
end;

class function TWSConfigView.New(aController: IController): IView;
begin
  result := TWSConfigView.create(nil);
  result.Controller(aController);
end;

/// adiciona os componentes a serem gravados na configura��o em uma lista
///
procedure TWSConfigView.AddControls;
begin
  /// dados do servidor
  ///
  FList.Add(WSPort);
  /// conex�es de Banco de Dados
  FList.Add(DriverID);
  FList.Add(Server);
  FList.Add(Database);
  FList.Add(User_Name);
  FList.Add(Password);
end;

/// escreve os dados no arquivo de configura��o
procedure TWSConfigView.Button1Click(Sender: TObject);
begin
  FList.WriteConfig;
  close;
end;

/// inicializa o controller do VIEW
function TWSConfigView.ConnectionString: string;
var
  str: TStringList;
begin
  with GetServer do
    try
      result := asString;
    finally
      free;
    end;
end;

function TWSConfigView.Controller(const aController: IController): IView;
begin
  result := inherited Controller(aController);
end;

function TWSConfigView.This: TObject;
begin
  result := inherited This;
end;

function TWSConfigView.ThisAs: TWSConfigView;
begin
  result := self;
end;

function TWSConfigView.ShowView(const AProc: TProc<IView>): integer;
begin
  inherited;
end;

end.
