program NewMVCAppFACADE;

// C�digo gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017

uses
  Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  NewMVCAppFACADE.Controller in 'Controllers\NewMVCAppFACADE.Controller.pas',
  NewMVCAppFACADE.Controller.Interf in 'Controllers\NewMVCAppFACADE.Controller.Interf.pas',
  NewMVCAppFACADEView in 'Views\NewMVCAppFACADEView.pas' {NewMVCAppFACADEView},
  PDVSat.Model in 'PDVSat\PDVSat.Model.pas',
  PDVSat.Model.Interf in 'PDVSat\PDVSat.Model.Interf.pas';

begin
  ApplicationController.run( TNewMVCAppFACADEController.new ,
  function:boolean
   begin
      // retornar True se o applicatio pode ser carregado
      //          False se n�o foi autorizado inicializa��o
      result := true;
    end);
end.
