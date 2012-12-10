unit DHibernate.Attributes;

{******************************************************************************}
{                                                                              }
{ Delphi Hibernate                                                             }
{                                                                              }
{ Copyright (c) 2012                                                           }
{   Cesar Romero <cesarliws@gmail.com>                                         }
{   License info: read license.txt                                             }
{                                                                              }
{******************************************************************************}

interface

uses
  System.Classes,
  System.Rtti,
  System.SysUtils,
  System.TypInfo,
  DHibernate.Mapping;

type
{$SCOPEDENUMS ON}
  TColumnProperty = (
    LazyLoad,
    NoInsert,
    NoUpdate,
    Required,
    Unique,
    Version
  );

  TInheritanceType = (
    Single,
    Joined
  );

  TTemporalType = (
    Date,
    DateTime,
    Time,
    TimeStamp
  );
{$SCOPEDENUMS OFF}

  TMultiplicity = DHibernate.Mapping.TMultiplicity;

  DiscriminatorColumn = class(TCustomAttribute)
  end;

  DiscriminatorValue = class(TCustomAttribute)
  end;

  Entity = class(TCustomAttribute)
  private
    FAccess: TAccess;
  public
    constructor Create; overload;
    constructor Create(Access: TAccess); overload;
    property Access: TAccess read FAccess;
  end;

  JoinColumn = class(TCustomAttribute)
  private
    FName: string;
    FReferencedColumnName: string;
  public
    constructor Create(const Name: string); overload;
    constructor Create(const Name: string; ReferencedColumnName: string); overload;
    property Name: string read FName;
    property ReferencedColumnName: string read FReferencedColumnName;
  end;

  ForeignJoinColumn = class(TCustomAttribute)
  private
    FName: string;
    FReferencedColumnName: string;
  public
    constructor Create(const Name: string); overload;
    constructor Create(const Name: string; ReferencedColumnName: string); overload;
    property Name: string read FName;
    property ReferencedColumnName: string read FReferencedColumnName;
 end;

  PrimaryKeyJoinColumn = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(const Name: string);
    property Name: string read FName;
  end;

  Table = class(TCustomAttribute)
  private
    FName: string;
    FSchema: string;
  public
    constructor Create(Name: string); overload;
    constructor Create(Name, Schema: string); overload;
    property Name: string read FName;
    property Schema: string read FSchema;
  end;

  TColumnProperties = set of TColumnProperty;

  Column = class(TCustomAttribute)
  private
    FDataType: TDataType;
    FName: string;
    FProperties: TColumnProperties;
    FSize: Integer;
  public
    constructor Create(const Name: string; DataType: TDataType); overload;
    constructor Create(const Name: string; DataType: TDataType; Properties: TColumnProperties); overload;
    constructor Create(const Name: string; DataType: TDataType; Properties: TColumnProperties; Size: Integer); overload;

    property DataType: TDataType read FDataType;
    property Name: string read FName;
    property Properties: TColumnProperties read FProperties;
    property Size: Integer read FSize;
  end;

  FloatColumn = class(TCustomAttribute)
  private
    FPrecision: Integer;
    FScale: Integer;
  public
    constructor Create(Precision, Scale: Integer);

    property Precision: Integer read FPrecision;
    property Scale: Integer read FScale;
  end;

  Embedded = class(TCustomAttribute)
  end;

  Enumeration = class(TCustomAttribute)
  strict private
    FEnumType: TEnumType;
    FValues: TArray<string>;
  strict protected
    procedure SetValue(const Value: string; Items: TStrings);
    procedure SetValues(const Values: array of string);
  public
    // TODO: TypeInfo: PTypeInfo;
    constructor Create(EnumType: TEnumType); overload;
    constructor Create(EnumType: TEnumType; const Values: array of string); overload;
    constructor Create(EnumType: TEnumType; const Values: array of Integer); overload;

    property EnumType: TEnumType read FEnumType;
    property Values: TArray<string> read FValues;
  end;

  Generated = class(TCustomAttribute)
  private
    FName: string;
    FGenerationTime: TGenerated;
    FGenetorClass: TClass;
    procedure SetName(const Value: string);
  public
    constructor Create(const Name: string; GenerationTime : TGenerated); overload;
    constructor Create(const Name: string; GenerationTime : TGenerated; GenetorClass: TClass); overload;

    property GenerationTime: TGenerated read FGenerationTime write FGenerationTime;
    property GenetorClass: TClass read FGenetorClass write FGenetorClass;
    property Name: string read FName write SetName;
  end;

  Id = class(TCustomAttribute)
  end;

  Relationship = class(TCustomAttribute)
  private
    FCascadeAction: TCascadeAction;
    FMultiplicity: TMultiplicity;
  public
    constructor Create(CascadeAction: TCascadeAction; Multiplicity: TMultiplicity);
    property CascadeAction: TCascadeAction read FCascadeAction;
    property Multiplicity: TMultiplicity read FMultiplicity;
  end;

  Inheritance = class(Relationship)
  private
    FInheritanceType: TInheritanceType;
  public
    constructor Create(InheritanceType: TInheritanceType);
    property InheritanceType: TInheritanceType read FInheritanceType;
  end;

  Temporal = class(TCustomAttribute)
  private
    FTemporalType: TTemporalType;
  public
    constructor Create(TemporalType: TTemporalType);
    property TemporalType: TTemporalType read FTemporalType;
  end;

  Transient = class(TCustomAttribute)
  end;

  Versionering = class(TCustomAttribute)
  end;

  Description = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const Value: string);
    property Value: string read FValue;
  end;

  EAttribute = class(Exception);
  EEnumeration = class(EAttribute);

const
  StringFirstChar = 1;

resourcestring
  SInvalidEnumSize = 'Invalid Enumeration Size';
  SInvalidEnumOrdinal = 'Invalid Ordinal Value';
  SInvalidEnumValue = 'Invalid Enumeration Value';

implementation

{ Table }

constructor Table.Create(Name: string);
begin
  Create(Name, '');
end;

constructor Table.Create(Name, Schema: string);
begin
  inherited Create;
  FName := Name;
  FSchema := Schema;
end;

{ Column }

constructor Column.Create(const Name: string; DataType: TDataType);
begin
  inherited Create;
  FName := Name;
  FDataType := DataType;
  FProperties := [];
end;

constructor Column.Create(const Name: string; DataType: TDataType; Properties: TColumnProperties);
begin
  Create(Name, DataType);
  FProperties := Properties;
end;

constructor Column.Create(const Name: string; DataType: TDataType; Properties: TColumnProperties; Size: Integer);
begin
  Create(Name, DataType, Properties);
  FSize := Size;
end;

{ Description }

constructor Description.Create(const Value: string);
begin
  inherited Create;
  FValue := Value;
end;

{ Generated }

constructor Generated.Create(const Name: string; GenerationTime: TGenerated; GenetorClass: TClass);
begin
  Create(Name, GenerationTime);
  FGenetorClass := GenetorClass;
end;

constructor Generated.Create(const Name: string; GenerationTime: TGenerated);
begin
  inherited Create;
  FName := Name;
  FGenerationTime := GenerationTime;
end;

procedure Generated.SetName(const Value: string);
begin
  FName := Value;
end;

{ Enumeration }

constructor Enumeration.Create(EnumType: TEnumType);
var
  EmptyValues: array of string;
begin
  SetLength(EmptyValues, 0);
  Create(EnumType, EmptyValues);
end;

constructor Enumeration.Create(EnumType: TEnumType; const Values: array of string);
begin
  inherited Create;
  FEnumType := EnumType;
  SetValues(Values)
end;

constructor Enumeration.Create(EnumType: TEnumType; const Values: array of Integer);
var
  Items: array of string;
  I: Integer;
begin
  SetLength(Items, Length(Values));
  for I := Low(Values) to High(Values) do
    Items[I] := IntToStr(Values[I]);
  Create(EnumType, Items);
end;

procedure Enumeration.SetValue(const Value: string; Items: TStrings);
begin
  case EnumType of
    TEnumType.Char:
      begin
        if (Length(Value) <> 1) or (Trim(Value) = '') then
          raise EEnumeration.Create(SInvalidEnumSize);
      end;

    TEnumType.Ordinal:
      begin
        if not TryStrToInt(Value, Ordinal) then
          raise EEnumeration.Create(SInvalidEnumOrdinal);
      end;

    TEnumType.String:
      begin
        if Trim(Value) = '' then
          raise EEnumeration.Create(SInvalidEnumValue);
      end;
  end;

  if EnumType in [TEnumType.Char, TEnumType.String] then
  begin
    if not CharInSet(Value[StringFirstChar], ['a'..'z', 'A'..'Z']) then
      raise EEnumeration.Create(SInvalidEnumValue);
  end;

  Items.Add(Value)
end;

procedure Enumeration.SetValues(const Values: array of string);
var
  I: Integer;
  Items: TStringList;
  Ordinal: Integer;
  Value: string;
begin
  Items := TStringList.Create;
  try
    Items.Duplicates := dupError;
    for I := Low(Values) to High(Values) do
    begin
      SetValue(Value[I], Items);
    end;

    SetLength(FValues, Items.Count);
    for I := 0 to Items.Count -1 do
      FValues[I] := Items[I];
  finally
    Items.Free;
  end;
end;

{ Entity }

constructor Entity.Create;
begin
  Create(TAccess.&Property);
end;

constructor Entity.Create(Access: TAccess);
begin
  inherited Create;
  FAccess := Access;
end;

{ Relationship }

constructor Relationship.Create(CascadeAction: TCascadeAction; Multiplicity: TMultiplicity);
begin
  inherited Create;
  FCascadeAction := CascadeAction;
  FMultiplicity := Multiplicity;
end;

{ Inheritance }

constructor Inheritance.Create(InheritanceType: TInheritanceType);
begin
  inherited Create(TCascadeAction.Cascade, TMultiplicity.OneToOne);
  FInheritanceType := InheritanceType;
end;

{ PrimaryKeyJoinColumn }

constructor PrimaryKeyJoinColumn.Create(const Name: string);
begin
  inherited Create;
  FName := Name;
end;

{ Temporal }

constructor Temporal.Create(TemporalType: TTemporalType);
begin
  inherited Create;
  FTemporalType := TemporalType;
end;

{ JoinColumn }

constructor JoinColumn.Create(const Name: string);
begin
  Create(Name, '');
end;

constructor JoinColumn.Create(const Name: string; ReferencedColumnName: string);
begin
  inherited Create;
  FName := Name;
  FReferencedColumnName := ReferencedColumnName;
end;

{ ForeignJoinColumn }

constructor ForeignJoinColumn.Create(const Name: string);
begin
  Create(Name, '');
end;

constructor ForeignJoinColumn.Create(const Name: string; ReferencedColumnName: string);
begin
  inherited Create;
  FName := Name;
  FReferencedColumnName := ReferencedColumnName;
end;

{ FloatColumn }

constructor FloatColumn.Create(Precision, Scale: Integer);
begin
  inherited Create;
  FPrecision := Precision;
  FScale := Scale;
end;

end.

