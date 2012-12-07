unit DHibernate.Mapping;

{******************************************************************************}
{                                                                              }
{ DDC Framework                                                                }
{                                                                              }
{ Copyright (c) 2012                                                           }
{   Cesar Romero <cesarliws@gmail.com>                                         }
{   Diego Garcia <diego.unitone@gmail.com>                                     }
{                                                                              }
{******************************************************************************}

// nhibernate-mapping.xsd

interface

uses
  Data.DB,
  Generics.Collections;

type
{$SCOPEDENUMS ON}
  TCascadeAction = (
    None,
    Cascade,
    SetNull,
    SetDefault
  );

  TMultiplicity = (
    OneToOne,
    OneToMany,
    ManyToOne,
    ManyToMany
  );

  TSortingOrder = (
    NoSort,
    Ascending,
    Descending
  );

  TEnumType = (
    Char,
    Ordinal,
    &String
  );

  // Access
  TAccess = (
    &Property,
    Field,
    NoSetter,
    &Class
  );

  TPolymorphism = (
    Implicit,
    Explicit
  );

  TLocking = (
    Version, // check the version/timestamp columns
    All,     // check all columns
    Dirty,   // check the changed columns
    NoLock   // do not use optimistic locking
  );

  TGeneratorType = (
    Increment,
    Identity,
    Sequence,
    Hilo,
    SeqHilo,
    UUIDHex,
    UUIDString,
    GUID,
    Native,
    Assigned,
    Foreign
  );

  TGenerated = (
    Never,
    Insert,
    Always
  );

{$SCOPEDENUMS OFF}

  TTableMapping = class;

  TDataType = Data.DB.TFieldType;

  TMappingDescription = class abstract
  private
    FDescription: string;
  public
    property Description: string read FDescription write FDescription;
  end;

  TColumnMapping = class(TMappingDescription)
  private
    FAccess: TAccess;
    FColumnName: string;
    FDataType: TDataType;
    FDefaultValue: string;
    FDiscriminator: Boolean;
    FFormula: string;
    FGenerated: TGenerated;
    FGeneratorClass: TClass;
    FLazy: Boolean;
    FNoInsert: Boolean;
    FNoUpdate: Boolean;
    FOptimisticLock: Boolean;
    FPrecision: Integer;
    FPrimaryKey: Boolean;
    FPropertyName: string;
    FRequired: Boolean;
    FScale: Integer;
    FSize: Integer;
    FUnique: Boolean;
    FVersion: Boolean;
  public
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property Discriminator: Boolean read FDiscriminator write FDiscriminator;
    property GeneratorClass: TClass read FGeneratorClass write FGeneratorClass;
    property Precision: Integer read FPrecision write FPrecision;
    property PrimaryKey: Boolean read FPrimaryKey write FPrimaryKey;
    property Required: Boolean read FRequired write FRequired;
    property Scale: Integer read FScale write FScale;
    property Size: Integer read FSize write FSize;
    property Unique: Boolean read FUnique write FUnique;
    property Version: Boolean read FVersion write FVersion;
  public
    property Access: TAccess read FAccess write FAccess;
    property ColumnName: string read FColumnName write FColumnName;
    property DataType: TDataType read FDataType write FDataType;
    property Formula: string read FFormula write FFormula;
    property Generated: TGenerated read FGenerated write FGenerated;
    property Lazy: Boolean read FLazy write FLazy;
    property NoInsert: Boolean read FNoInsert write FNoInsert;
    property NoUpdate: Boolean read FNoUpdate write FNoUpdate;
    property OptimisticLock: Boolean read FOptimisticLock write FOptimisticLock;
    property PropertyName: string read FPropertyName write FPropertyName;
  end;

  TIdMapping = TArray<TColumnMapping>;
  TColumnMappingList = class(TObjectList<TColumnMapping>);

  TEnumerationMapping = class(TMappingDescription)
  private
    FEnumType: TEnumType;
    FValues: TArray<string>;
  public
    constructor Create(EnumType: TEnumType; const Values: array of string);

    property EnumType: TEnumType read FEnumType;
    property Values: TArray<string> read FValues;
  end;

   TEnumerationMappingList = class(TObjectList<TEnumerationMapping>);

  TIndexMapping = class(TMappingDescription)
  private
    FColumns: TColumnMappingList;
    FName: string;
    FSorting: TSortingOrder;
    FUnique: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    property Columns: TColumnMappingList read FColumns;
    property Name: string read FName write FName;
    property Sorting: TSortingOrder read FSorting write FSorting;
    property Unique: Boolean read FUnique write FUnique;
  end;

  TIndexMappingList = class(TObjectList<TIndexMapping>);

  TCascadeMapping = class
  private
    FDelete: Boolean;
    FMerge: Boolean;
    FAction: TCascadeAction;
    FUpdate: Boolean;
  public
    constructor Create;
    property Action: TCascadeAction read FAction write FAction;
    property Delete: Boolean read FDelete write FDelete;
    property Merge: Boolean read FMerge write FMerge;
    property Update: Boolean read FUpdate write FUpdate;

  end;

  TRelationshipMapping = class(TMappingDescription)
  private
    FCascade: TCascadeMapping;
    FColumns: TColumnMappingList;
    FForeignColumns: TColumnMappingList;
    FConstraintName: string;
    FForeignTable: TTableMapping;
    FLazyLoad: Boolean;
    FMultiplicity: TMultiplicity;
    FRequired: Boolean;
    FTable: TTableMapping;
  public
    constructor Create;
    destructor Destroy; override;

    property Cascade: TCascadeMapping read FCascade;
    property Columns: TColumnMappingList read FColumns;
    property ConstraintName: string read FConstraintName write FConstraintName;
    property ForeignColumns: TColumnMappingList read FForeignColumns;
    property ForeignTable: TTableMapping read FForeignTable write FForeignTable;
    property LazyLoad: Boolean read FLazyLoad write FLazyLoad;
    property Multiplicity: TMultiplicity read FMultiplicity write FMultiplicity;
    property Required: Boolean read FRequired write FRequired;
    property Table: TTableMapping read FTable write FTable;
  end;

  TRelationshipMappingList = class(TObjectList<TRelationshipMapping>);

  TTableMapping = class(TMappingDescription)
    FAbstractClass: Boolean;
    FAncestor: TTableMapping;
    FColumns: TColumnMappingList;
    FDiscriminatorValue: string;
    FDynamicInsert: Boolean;
    FDynamicUpdate: Boolean;
    FId: TIdMapping;
    FIndexes: TIndexMappingList;
    FLazy: Boolean;
    FMutable: Boolean;
    FOptimisticLock: TLocking;
    FPersisterClass: TClass;
    FPolymorphism: TPolymorphism;
    FProxyClass: TClass;
    FRelationships: TRelationshipMappingList;
    FSchema: string;
    FSelectBeforeUpdate: Boolean;
    FSingleTable: Boolean;
    FTableName: string;
    FWhere: string;
  private
    FEntityClass: TClass;
  public
    constructor Create;
    destructor Destroy; override;

    property Ancestor: TTableMapping read FAncestor write FAncestor;
    property Columns: TColumnMappingList read FColumns;
    property Id: TIdMapping read FId write FId;
    property Indexes: TIndexMappingList read FIndexes;
    property Relationships: TRelationshipMappingList read FRelationships;
    property SingleTable: Boolean read FSingleTable write FSingleTable;
  public
    property AbstractClass: Boolean read FAbstractClass write FAbstractClass;
    property DiscriminatorValue: string read FDiscriminatorValue write FDiscriminatorValue;
    property DynamicInsert: Boolean read FDynamicInsert write FDynamicInsert;
    property DynamicUpdate: Boolean read FDynamicUpdate write FDynamicUpdate;
    property EntityClass: TClass read FEntityClass write FEntityClass;
    property Lazy: Boolean read FLazy write FLazy;
    property Mutable: Boolean read FMutable write FMutable;
    property OptimisticLock: TLocking read FOptimisticLock write FOptimisticLock;
    property PersisterClass: TClass read FPersisterClass write FPersisterClass;
    property Polymorphism: TPolymorphism read FPolymorphism write FPolymorphism;
    property ProxyClass: TClass read FProxyClass write FProxyClass;
    property Schema: string read FSchema write FSchema;
    property SelectBeforeUpdate: Boolean read FSelectBeforeUpdate write FSelectBeforeUpdate;
    property TableName: string read FTableName write FTableName;
    property Where: string read FWhere write FWhere;
  end;

  TTableMappingList = class(TObjectList<TTableMapping>);

  TMapping = class
  private
    FAutoImport: Boolean;
    FCascade: TCascadeMapping;
    FDefaultAccess: TAccess;
    FDefaultLazy: Boolean;
    FEnums: TEnumerationMappingList;
    FSchema: string;
    FTables: TTableMappingList;
  public
    constructor Create;
    destructor Destroy; override;

    property Enums: TEnumerationMappingList read FEnums;
    property Tables: TTableMappingList read FTables;
  public
    property AutoImport: Boolean read FAutoImport write FAutoImport;
    property Cascade: TCascadeMapping read FCascade;
    property DefaultAccess: TAccess read FDefaultAccess write FDefaultAccess;
    property DefaultLazy: Boolean read FDefaultLazy write FDefaultLazy;
    property Schema: string read FSchema write FSchema;
  end;

implementation

{ TEnumerationMapping }

constructor TEnumerationMapping.Create(EnumType: TEnumType; const Values: array of string);
var
  I: Integer;
begin
  inherited Create;
  FEnumType := EnumType;
  SetLength(FValues, Length(Values));
  for I := Low(Values) to High(Values) do
    FValues[I] := Values[I];
end;

{ TIndexMapping }

constructor TIndexMapping.Create;
begin
  inherited;
  FColumns := TColumnMappingList.Create;
  FSorting := TSortingOrder.Ascending;
end;

destructor TIndexMapping.Destroy;
begin
  FColumns.Free;
  inherited;
end;

{ TRelationshipMapping }

constructor TRelationshipMapping.Create;
begin
  inherited;
  FCascade := TCascadeMapping.Create;
  FColumns := TColumnMappingList.Create;
  FForeignColumns := TColumnMappingList.Create;
end;

destructor TRelationshipMapping.Destroy;
begin
  FCascade.Free;
  FColumns.Free;
  FForeignColumns.Free;
  inherited;
end;

{ TTableMapping }

constructor TTableMapping.Create;
begin
  inherited;
  FColumns := TColumnMappingList.Create;
  FIndexes := TIndexMappingList.Create;
  FRelationships := TRelationshipMappingList.Create;
  FMutable := True;
  FPolymorphism := TPolymorphism.Implicit;
end;

destructor TTableMapping.Destroy;
begin
  FColumns.Free;
  FIndexes.Free;
  FRelationships.Free;
  inherited;
end;

{ TMapping }

constructor TMapping.Create;
begin
  inherited;
  FEnums := TEnumerationMappingList.Create;
  FTables := TTableMappingList.Create;
  FCascade := TCascadeMapping.Create;
  FAutoImport := True;
  FDefaultAccess := TAccess.&Property;
end;

destructor TMapping.Destroy;
begin
  FCascade.Free;
  FEnums.Free;
  FTables.Free;
  inherited;
end;

constructor TCascadeMapping.Create;
begin
  inherited Create;
  FAction := TCascadeAction.None;
end;

end.
