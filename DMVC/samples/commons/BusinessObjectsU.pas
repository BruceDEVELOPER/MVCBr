unit BusinessObjectsU;

interface

uses
  ObjectsMappers, Generics.Collections;

type

  [MapperJSONNaming(JSONNameLowerCase)]
  TPerson = class
  private
    FLastName: string;
    FDOB: TDate;
    FFirstName: string;
    FMarried: boolean;
    procedure SetDOB(const Value: TDate);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetMarried(const Value: boolean);
  public
    function Equals(Obj: TObject): boolean; override;
    // [MapperJsonSer('nome')]
    property FirstName: string read FFirstName write SetFirstName;
    // [DoNotSerialize]
    property LastName: string read FLastName write SetLastName;
    property DOB: TDate read FDOB write SetDOB;
    property Married: boolean read FMarried write SetMarried;
    class function GetNew(AFirstName, ALastName: string; ADOB: TDate; AMarried: boolean): TPerson;
    class function GetList: TObjectList<TPerson>;
  end;

  TPeople = class(TObjectList<TPerson>);

  [MapperJSONNaming(JSONNameLowerCase)]
  TCustomer = class
  private
    FName: string;
    FAddressLine2: string;
    FAddressLine1: string;
    FContactFirst: string;
    FCity: string;
    FContactLast: string;
    procedure SetAddressLine1(const Value: string);
    procedure SetAddressLine2(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetContactFirst(const Value: string);
    procedure SetContactLast(const Value: string);
    procedure SetName(const Value: string);
  public
    property name: string read FName write SetName;
    [MapperTransient]
    property ContactFirst: string read FContactFirst write SetContactFirst;
    [MapperTransient]
    property ContactLast: string read FContactLast write SetContactLast;
    property AddressLine1: string read FAddressLine1 write SetAddressLine1;
    property AddressLine2: string read FAddressLine2 write SetAddressLine2;
    property City: string read FCity write SetCity;
    class function GetList: TObjectList<TCustomer>;
  end;

  [MapperJSONNaming(JSONNameLowerCase)]
  TProgrammer = class(TPerson)
  private
    FSkills: string;
    procedure SetSkills(const Value: string);
  public
    property Skills: string read FSkills write SetSkills;
  end;

  [MapperJSONNaming(JSONNameLowerCase)]
  TPhilosopher = class(TPerson)
  private
    FMentors: string;
    procedure SetMentors(const Value: string);
  public
    property Mentors: string read FMentors write SetMentors;
  end;

implementation

uses
  System.SysUtils;

{ TPerson }

function TPerson.Equals(Obj: TObject): boolean;
begin
  Result := Obj is TPerson;
  if Result then
  begin
    Result := Result and (TPerson(Obj).LastName = Self.LastName);
    Result := Result and (TPerson(Obj).FirstName = Self.FirstName);
    Result := Result and (TPerson(Obj).Married = Self.Married);
    Result := Result and (TPerson(Obj).DOB = Self.DOB);
  end;
end;

class function TPerson.GetList: TObjectList<TPerson>;
begin
  Result := TObjectList<TPerson>.Create;
  Result.Add(TPerson.GetNew('Tony', 'Stark', EncodeDate(1965, 5, 15), true));
  Result.Add(TPerson.GetNew('Stevene', 'Rogers', 0, true));
  Result.Add(TPerson.GetNew('Bruce', 'Banner', 0, true));
end;

class function TPerson.GetNew(AFirstName, ALastName: string; ADOB: TDate;
  AMarried: boolean): TPerson;
begin
  Result := TPerson.Create;
  Result.FLastName := ALastName;
  Result.FFirstName := AFirstName;
  Result.FDOB := ADOB;
  Result.FMarried := AMarried;
end;

procedure TPerson.SetDOB(const Value: TDate);
begin
  FDOB := Value;
end;

procedure TPerson.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TPerson.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

procedure TPerson.SetMarried(const Value: boolean);
begin
  FMarried := Value;
end;

{ TCustomer }

class function TCustomer.GetList: TObjectList<TCustomer>;
var
  C1: TCustomer;
  I: Integer;
begin
  Result := TObjectList<TCustomer>.Create(true);
  for I := 1 to 1000 do
  begin
    C1 := TCustomer.Create;
    C1.name := I.ToString + ': bit Time Professionals';
    C1.ContactFirst := 'Daniele';
    C1.ContactLast := 'Teti';
    C1.AddressLine1 := 'Via di Valle Morta 10';
    C1.City := 'Rome, IT';
    Result.Add(C1);

    C1 := TCustomer.Create;
    C1.name := I.ToString + ': Stark Industries';
    C1.ContactFirst := 'Tony';
    C1.ContactLast := 'Stark';
    C1.AddressLine1 := 'Superhero Street 555';
    C1.City := 'Palo Alto, CA';
    Result.Add(C1);

    C1 := TCustomer.Create;
    C1.name := I.ToString + ': Google Inc';
    C1.ContactFirst := 'Larry';
    C1.ContactLast := 'Page';
    C1.AddressLine1 := '';
    C1.City := 'Mountain View, CA';
    Result.Add(C1);
  end;

end;

procedure TCustomer.SetAddressLine1(const Value: string);
begin
  FAddressLine1 := Value;
end;

procedure TCustomer.SetAddressLine2(const Value: string);
begin
  FAddressLine2 := Value;
end;

procedure TCustomer.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TCustomer.SetContactFirst(const Value: string);
begin
  FContactFirst := Value;
end;

procedure TCustomer.SetContactLast(const Value: string);
begin
  FContactLast := Value;
end;

procedure TCustomer.SetName(const Value: string);
begin
  FName := Value;
end;

{ TProgrammer }

procedure TProgrammer.SetSkills(const Value: string);
begin
  FSkills := Value;
end;

{ TPhilosopher }

procedure TPhilosopher.SetMentors(const Value: string);
begin
  FMentors := Value;
end;

end.
