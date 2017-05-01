{//************************************************************//}
{//                                                            //}
{//         C�digo gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 13/02/2017 22:49:37                                  //}
{//************************************************************//}
Unit FMXBasico.ViewModel;
interface
{.$I ..\inc\mvcbr.inc}
uses MVCBr.Interf, MVCBr.ViewModel, FMXBasico.ViewModel.Interf;
Type
///  Object Factory para o ViewModel
    TFMXBasicoViewModel=class(TViewModelFactory,
      IFMXBasicoViewModel, IViewModelAs<IFMXBasicoViewModel>)
    public
      function ViewModelAs:IFMXBasicoViewModel;
      class function new():IFMXBasicoViewModel;overload;
      class function new(const AController:IController):IFMXBasicoViewModel; overload;
      procedure AfterInit;override;
    end;
implementation
function TFMXBasicoViewModel.ViewModelAs:IFMXBasicoViewModel;
begin
  result := self;
end;
class function TFMXBasicoViewModel.new():IFMXBasicoViewModel;
begin
  result := new(nil);
end;
/// <summary>
///   New cria uma nova inst�ncia para o ViewModel
/// </summary>
/// <param name="AController">
///   AController � o controller ao qual o ViewModel esta
///   ligado
/// </param>
class function TFMXBasicoViewModel.new(const AController:IController):IFMXBasicoViewModel;
begin
  result := TFMXBasicoViewModel.create;
  result.controller(AController);
end;
procedure TFMXBasicoViewModel.AfterInit;
begin
    // evento disparado apos a definicao do Controller;
end;
end.
