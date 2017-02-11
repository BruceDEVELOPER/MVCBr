unit MVCBr.FormView;

interface

uses {$IFDEF FMX} FMX.Forms, System.UiTypes, {$ELSE} VCL.Forms, {$ENDIF} System.Classes, System.SysUtils, System.RTTI,
  MVCBr.Interf, MVCBr.View;

type

{$IFDEF FMX}
  TFormClass = class of TForm;
{$ENDIF}
  TViewFactoryAdapter = class;

  IViewAdpater = interface(IView)
    ['{A5FCFDC8-67F2-4202-AED1-95314077F28F}']
    function Form: TForm;
    function ThisAs: TViewFactoryAdapter;
  end;

  /// <summary>
  /// TViewFactoryAdpater � um conector para receber um FORM,
  /// a ser utilizado para formularios que n�o herdam diretamente de TFormFactory
  /// </summary>
  TViewFactoryAdapter = class(TViewFactory, IViewAdpater)
  private
    FisShowModal: boolean;
    FOnProc: TProc<IView>;
    procedure SetisShowModal(const Value: boolean);
  protected
    FForm: TForm;
    procedure DoClose(Sender: TObject; var Action: TCloseAction);
  public
    class function New(AClass: TFormClass;
      const AShowModal: boolean = true): IView;
    property isShowModal: boolean read FisShowModal write SetisShowModal;
    function ShowView(const AProc: TProc<IView>): Integer; override;
    function Form: TForm;
    function ThisAs: TViewFactoryAdapter;
  end;

  /// <summary>
  /// TFormFactory � utilizado para heran�a dos TForms para transformar o FORM em VIEW no MVCBr
  /// </summary>
  TFormFactory = class(TForm, IMVCBrBase, IView)
  private
    function GetPropertyValue(ANome: string): TValue;
    procedure SetPropertyValue(ANome: string; const Value: TValue);
  protected
    FOnCloseProc: TProc<IView>;
    FController: IController;
    FShowModal: boolean;
    procedure SetController(const AController: IController);
    function Controller(const AController: IController): IView; virtual;
    procedure AfterConstruction; override;
    procedure SetShowModal(const AShowModal: boolean);
    /// Retorna se a apresenta��o do formul�rio � ShowModal
    function GetShowModal: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property isShowModal: boolean read GetShowModal write SetShowModal;
    /// Retorna o controller ao qual a VIEW esta conectada
    function GetController: IController; virtual;
    /// Retorna o SELF
    function This: TObject; virtual;
    /// Executa um method gen�rico do FORM/VIEW
    function InvokeMethod<T>(AMethod: string; const Args: TArray<TValue>): T;
    function ResolveController(const IID: TGuid): IController; virtual;
    /// Obter ou Alterar o valor de uma propriedade do ObjetoClass  (VIEW)
    property PropertyValue[ANome: string]: TValue read GetPropertyValue
      write SetPropertyValue;
    /// Apresenta o VIEW para o usuario
    function ShowView(const AProc: TProc<IView>): Integer; overload; virtual;
    function ShowView(const IIDController: TGuid; const AProc: TProc<IView>)
      : IView; overload; virtual;
    /// Evento para atualizar os dados da VIEW
    function Update: IView; virtual;
  end;

implementation

{ TViewFormFacotry }
procedure TFormFactory.AfterConstruction;
begin
  inherited;
  FShowModal := true;
end;

function TFormFactory.Controller(const AController: IController): IView;
begin
  result := self;
  FController := AController;
end;

constructor TFormFactory.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TFormFactory.Destroy;
begin
  if assigned(FController) then
    FController.This.RevokeInstance(FController);
  inherited;
end;

function TFormFactory.GetController: IController;
begin
  result := FController;
end;

function TFormFactory.GetPropertyValue(ANome: string): TValue;
begin
  result := TMVCBr.GetProperty(self, ANome);
end;

function TFormFactory.GetShowModal: boolean;
begin
  result := FShowModal;
end;

function TFormFactory.InvokeMethod<T>(AMethod: string;
  const Args: TArray<TValue>): T;
begin
  result := TMVCBr.InvokeMethod<T>(self, AMethod, Args);
end;

function TFormFactory.ResolveController(const IID: TGuid): IController;
begin
  result := FController.This.ResolveController(IID);
end;

procedure TFormFactory.SetController(const AController: IController);
begin
  FController := AController;
end;

procedure TFormFactory.SetPropertyValue(ANome: string; const Value: TValue);
begin
  TMVCBr.SetProperty(self, ANome, Value);
end;

procedure TFormFactory.SetShowModal(const AShowModal: boolean);
begin
  FShowModal := AShowModal;
end;

function TFormFactory.ShowView(const IIDController: TGuid;
  const AProc: TProc<IView>): IView;
var
  LController: IController;
begin
  LController := ResolveController(IIDController);
  if assigned(LController) then
  begin
    result := LController.GetView;
    result.ShowView(AProc);
  end;
end;

function TFormFactory.ShowView(const AProc: TProc<IView>): Integer;
begin
  result := 0;
{$IFDEF FMX}
  FOnCloseProc := AProc;
  Show;
{$ELSE}
  if FShowModal then
    result := ord(ShowModal);
  if assigned(AProc) then
    AProc(self);
{$ENDIF}
end;

function TFormFactory.This: TObject;
begin
  result := self;
end;

function TFormFactory.Update: IView;
begin
  result := self;
end;

{ TViewFactoryAdapter }

procedure TViewFactoryAdapter.DoClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if assigned(FOnProc) then
    FOnProc(self);
end;

function TViewFactoryAdapter.Form: TForm;
begin
  result := FForm;
end;

class function TViewFactoryAdapter.New(AClass: TFormClass;
  const AShowModal: boolean): IView;
var
  obj: TViewFactoryAdapter;
begin
  obj := TViewFactoryAdapter.Create;
  obj.FForm := AClass.Create(nil);
  obj.isShowModal := AShowModal;
  result := obj;
end;

procedure TViewFactoryAdapter.SetisShowModal(const Value: boolean);
begin
  FisShowModal := Value;
end;

function TViewFactoryAdapter.ShowView(const AProc: TProc<IView>): Integer;
begin
  FOnProc := AProc;
  if isShowModal then
  begin
    result := ord(FForm.ShowModal);
    if assigned(AProc) then
      AProc(self);
  end
  else
  begin
    FForm.OnClose := DoClose;
    FForm.Show;
  end;
end;

function TViewFactoryAdapter.ThisAs: TViewFactoryAdapter;
begin
  result := self;
end;

end.
