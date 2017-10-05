unit ORMBr.model.VENDAS;

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
  [PrimaryKey('DATA', NotInc, NoSort, False, 'Chave prim�ria')]
  [PrimaryKey('DOCUMENTO', NotInc, NoSort, False, 'Chave prim�ria')]
  TVENDAS = class
  private
    { Private declarations }
    FDATA: TDateTime;
    FDOCUMENTO: string;
    FCLIENTE: Nullable<double>;
    FTOTAL: Nullable<Currency>;
  public
    { Public declarations }
    [Restrictions([NotNull])]
    [Column('DATA', ftDateTime)]
    [Dictionary('DATA', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DATA: TDateTime read FDATA write FDATA;

    [Restrictions([NotNull])]
    [Column('DOCUMENTO', ftString,15)]
    [Dictionary('DOCUMENTO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property DOCUMENTO: string read FDOCUMENTO write FDOCUMENTO;

    [Column('CLIENTE', ftFloat,10,0)]
    [Dictionary('CLIENTE', 'Mensagem de valida��o', '', '', '', taCenter)]
    property CLIENTE: Nullable<double> read FCLIENTE write FCLIENTE;

    [Column('TOTAL', ftCurrency,15,4)]
    [Dictionary('TOTAL', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property TOTAL: Nullable<Currency> read FTOTAL write FTOTAL;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TVENDAS)

end.
