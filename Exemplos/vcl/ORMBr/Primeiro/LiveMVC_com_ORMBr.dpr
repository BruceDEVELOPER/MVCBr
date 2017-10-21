program LiveMVC_com_ORMBr;

// C�digo gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017

uses
  Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  LiveMVC_com_ORMBr.Controller in 'Controllers\LiveMVC_com_ORMBr.Controller.pas',
  LiveMVC_com_ORMBr.Controller.Interf in 'Controllers\LiveMVC_com_ORMBr.Controller.Interf.pas',
  LiveMVC_com_ORMBrView in 'Views\LiveMVC_com_ORMBrView.pas' {LiveMVC_com_ORMBrView},
  LiveORM.Model in 'Models\LiveORM.Model.pas',
  ormbr.model.CLIENTES in 'Modelos\ormbr.model.CLIENTES.pas';

function CheckApplicationAuth:boolean; //rizado inicializa��o
 begin
  result := true;
end;

begin
/// Inicializa o Controller e Roda o MainForm
if CheckApplicationAuth then
  ApplicationController.Run(TLiveMVC_com_ORMBrController.New);
end.
