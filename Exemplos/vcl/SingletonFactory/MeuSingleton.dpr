program MeuSingleton;

// C�digo gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017
uses
  Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  MeuSingleton.Controller in 'Controllers\MeuSingleton.Controller.pas',
  MeuSingleton.Controller.Interf in 'Controllers\MeuSingleton.Controller.Interf.pas',
  MeuSingletonView in 'MeuSingletonView.pas' {MeuSingletonView},
  singleton.MinhaClasse in 'Singleton\singleton.MinhaClasse.pas';

{$R *.res}
function CheckApplicationAuth: boolean;
begin
  // retornar True se o applicatio pode ser carregado
  //          False se n�o foi autorizado inicializa��o
  result := true;
end;

begin
/// Inicializa o Controller e Roda o MainForm
if CheckApplicationAuth then
  ApplicationController.Run(TMeuSingletonController.New);
end.
