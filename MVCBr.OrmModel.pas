unit MVCBr.OrmModel;
{ *************************************************************************** }
{ }
{ MVCBr � o resultado de esfor�os de um grupo }
{ }
{ Copyright (C) 2017 MVCBr }
{ }
{ amarildo lacerda }
{ http://www.tireideletra.com.br }
{ }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }

interface

uses System.Classes, System.SysUtils, MVCBr.Interf, MVCBr.Model,
  MVCBr.Controller;

Type

  TOrmModelFactory = class(TModelFactory, IModel)
  protected
    FController: IController;
  public
    function Controller(const AController: IController): IModel;
      reintroduce; virtual;
  end;

implementation

{ TPersistentModelFactory }

function TOrmModelFactory.Controller(const AController: IController): IModel;
begin
  FController := AController;
{$IFNDEF BPL}
  ModelTypes := [mtOrmModel];
{$ENDIF}
end;

end.
