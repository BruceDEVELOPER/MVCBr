unit ormbr.model.vendas_item;

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
  [Table('VENDAS_ITEM', '')]
  [PrimaryKey('DOCUMENTO', NotInc, NoSort, False, 'Chave prim�ria')]
  TVENDAS_ITEM = class
  private
    { Private declarations } 
    FDATA: TDateTime;
    FDOCUMENTO: Integer;
    FPRODUTOS_CODIGO: Nullable<String>;
    FQTDE: Nullable<Double>;
    FPRECO: Nullable<Double>;
    FVALOR: Nullable<Double>;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('DATA', ftDateTime)]
    [Dictionary('DATA', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DATA: TDateTime read FDATA write FDATA;

    [Restrictions([NotNull])]
    [Column('DOCUMENTO', ftInteger)]
    [Dictionary('DOCUMENTO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property DOCUMENTO: Integer read FDOCUMENTO write FDOCUMENTO;

    [Column('PRODUTOS_CODIGO', ftString, 30)]
    [Dictionary('PRODUTOS_CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PRODUTOS_CODIGO: Nullable<String> read FPRODUTOS_CODIGO write FPRODUTOS_CODIGO;

    [Column('QTDE', ftBCD, 18, 4)]
    [Dictionary('QTDE', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property QTDE: Nullable<Double> read FQTDE write FQTDE;

    [Column('PRECO', ftBCD, 18, 4)]
    [Dictionary('PRECO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PRECO: Nullable<Double> read FPRECO write FPRECO;

    [Column('VALOR', ftBCD, 18, 4)]
    [Dictionary('VALOR', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VALOR: Nullable<Double> read FVALOR write FVALOR;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TVENDAS_ITEM)

end.
