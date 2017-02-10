{ //************************************************************// }
{ //                                                            // }
{ //         C�digo gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br                                // }
{ //************************************************************// }
{ // Data: 09/02/2017 21:37:09                                  // }
{ //************************************************************// }
unit AureliosExemplo.Controller;

interface

{ .$I ..\inc\mvcbr.inc }
uses
  SysUtils,{$ifdef FMX} FMX.Forms,{$else} VCL.Forms,{$endif} buttons, classes, controls, MVCBr.Interf,
  MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
  System.RTTI, AureliosExemplo.Controller.Interf,
  AureliosExemplo.ViewModel, AureliosExemplo.ViewModel.Interf,
  AureliosExemploView;

type
  TAureliosExemploController = class(TControllerFactory,
    IAureliosExemploController, IThisAs<TAureliosExemploController>,
    IModelAs<IAureliosExemploViewModel>)
  protected
    Procedure DoCommand(ACommand: string;
      const AArgs: array of TValue); override;
  public
    // inicializar os m�dulos personalizados em CreateModules
    Procedure CreateModules; virtual;
    Constructor Create; override;
    Destructor Destroy; override;
    class function New(): IController; overload;
    class function New(const AView: IView; const AModel: IModel)
      : IController; overload;
    class function New(const AModel: IModel): IController; overload;
    function ThisAs: TAureliosExemploController;
    procedure init; override;
    function ModelAs: IAureliosExemploViewModel;
  end;

implementation

/// Creator para a classe Controller
Constructor TAureliosExemploController.Create;
begin
  inherited;
  /// Inicializar as Views...
  add(TAureliosExemploViewModel.New(self).ID('{AureliosExemplo.ViewModel}'));
  /// Inicializar os modulos
  CreateModules; // < criar os modulos persolnizados
end;

/// Finaliza o controller
Destructor TAureliosExemploController.Destroy;
begin
  inherited;
end;

/// Classe Function basica para criar o controller
class function TAureliosExemploController.New(): IController;
begin
  result := New(nil, nil);
end;

/// Classe para criar o controller com View e Model criado
class function TAureliosExemploController.New(const AView: IView;
  const AModel: IModel): IController;
var
  vm: IViewModel;
begin
  result := TAureliosExemploController.Create as IController;
  result.View(AView).add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
    begin
      vm.View(AView).Controller(result);
    end;
end;

/// Classe para inicializar o Controller com um Modulo inicialz.
class function TAureliosExemploController.New(const AModel: IModel)
  : IController;
begin
  result := New(nil, AModel);
end;

/// Cast para a interface local do controller
function TAureliosExemploController.ThisAs: TAureliosExemploController;
begin
  result := self;
end;

/// Cast para o ViewModel local do controller
function TAureliosExemploController.ModelAs: IAureliosExemploViewModel;
begin
  if count >= 0 then
    supports(GetModelByType(mtViewModel), IAureliosExemploViewModel, result);
end;

/// Executar algum comando customizavel
Procedure TAureliosExemploController.DoCommand(ACommand: string;
  const AArgs: Array of TValue);
begin
  inherited;
end;

/// Evento INIT chamado apos a inicializacao do controller
procedure TAureliosExemploController.init;
var
  ref: TAureliosExemploView;
begin
  inherited;
  if not assigned(FView) then
  begin
    Application.CreateForm(TAureliosExemploView, ref);
    supports(ref, IView, FView);
  end;
  AfterInit;
end;

/// Adicionar os modulos e MODELs personalizados
Procedure TAureliosExemploController.CreateModules;
begin
  // adicionar os seus MODELs aqui
  // exemplo: add( MeuModel.new(self) );
end;

initialization

/// Inicializa��o automatica do Controller ao iniciar o APP
// TAureliosExemploController.New(TAureliosExemploView.New,TAureliosExemploViewModel.New)).init();
/// Registrar Interface e ClassFactory para o MVCBr
RegisterInterfacedClass(TAureliosExemploController.ClassName,
  IAureliosExemploController, TAureliosExemploController);

finalization

/// Remover o Registro da Interface
unRegisterInterfacedClass(TAureliosExemploController.ClassName);

end.
