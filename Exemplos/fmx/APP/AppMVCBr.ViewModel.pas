{//************************************************************//}
{//                                                            //}
{//         C�digo gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 11/02/2017 22:18:59                                  //}
{//************************************************************//}
Unit AppMVCBr.ViewModel;
interface
{.$I ..\inc\mvcbr.inc}
uses MVCBr.Interf, MVCBr.ViewModel, AppMVCBr.ViewModel.Interf;
Type
///  Object Factory para o ViewModel
    TAppMVCBrViewModel=class(TViewModelFactory,
      IAppMVCBrViewModel, IViewModelAs<IAppMVCBrViewModel>)
    public
      function ViewModelAs:IAppMVCBrViewModel;
      class function new():IAppMVCBrViewModel;overload;
      class function new(const AController:IController):IAppMVCBrViewModel; overload;
      procedure AfterInit;override;
    end;
implementation
function TAppMVCBrViewModel.ViewModelAs:IAppMVCBrViewModel;
begin
  result := self;
end;
class function TAppMVCBrViewModel.new():IAppMVCBrViewModel;
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
class function TAppMVCBrViewModel.new(const AController:IController):IAppMVCBrViewModel;
begin
  result := TAppMVCBrViewModel.create;
  result.controller(AController);
end;
procedure TAppMVCBrViewModel.AfterInit;
begin
    // evento disparado apos a definicao do Controller;
end;
end.
