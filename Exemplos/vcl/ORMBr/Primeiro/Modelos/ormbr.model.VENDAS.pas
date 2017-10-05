unit ormbr.model.vendas;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 
  /// orm 
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('VENDAS', '')]
  [PrimaryKey('DOCUMENTO', NotInc, NoSort, False, 'Chave prim�ria')]
  TVENDAS = class
  private
    { Private declarations } 
    FDATA: TDateTime;
    FDOCUMENTO: String;
    FTOTAL: Nullable<Double>;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('DATA', ftDateTime)]
    [Dictionary('DATA', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DATA: TDateTime read FDATA write FDATA;

    [Restrictions([NotNull])]
    [Column('DOCUMENTO', ftString, 15)]
    [Dictionary('DOCUMENTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property DOCUMENTO: String read FDOCUMENTO write FDOCUMENTO;


    [Column('TOTAL', ftBCD, 18, 4)]
    [Dictionary('TOTAL', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property TOTAL: Nullable<Double> read FTOTAL write FTOTAL;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TVENDAS)

end.
