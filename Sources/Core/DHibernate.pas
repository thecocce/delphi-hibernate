unit DHibernate;

{******************************************************************************}
{                                                                              }
{ DDC Framework                                                                }
{                                                                              }
{ Copyright (c) 2012                                                           }
{   Cesar Romero <cesarliws@gmail.com>                                         }
{   Diego Garcia <diego.unitone@gmail.com>                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  Generics.Collections,
  System.Classes,
  System.SysUtils,
  DSharp.Core.Nullable,
  DSharp.Core.Lazy;


type
  {$REGION 'Nullable<T>'}
  Nullable<T> = record
  private
    FValue: T;
    FHasValue: string;
    procedure Clear;
    function GetValue: T;
    function GetHasValue: Boolean;
  public
    constructor Create(const Value: T); overload;
    constructor Create(const Value: Variant); overload;
    function Equals(const Value: Nullable<T>): Boolean;
    function GetValueOrDefault: T; overload;
    function GetValueOrDefault(const Default: T): T; overload;

    property HasValue: Boolean read GetHasValue;
    property Value: T read GetValue;

    class operator Implicit(const Value: Nullable<T>): T;
    class operator Implicit(const Value: Nullable<T>): Variant;
    class operator Implicit(const Value: Pointer): Nullable<T>;
    class operator Implicit(const Value: T): Nullable<T>;
    class operator Implicit(const Value: Variant): Nullable<T>;
    class operator Equal(const Left, Right: Nullable<T>): Boolean;
    class operator NotEqual(const Left, Right: Nullable<T>): Boolean;
  end;
  {$ENDREGION}

  // Basic Types
  BooleanType  = Nullable<Boolean>;
  CurrencyType = Nullable<Currency>;
  DateTimeType = Nullable<TDateTime>;
  DoubleType   = Nullable<Double>;
  GuidType     = Nullable<TGUID>;
  IntegerType  = Nullable<Integer>;
  StringType   = Nullable<string>;

  {$REGION 'Extra Types: AnsiString, NativeInt, Int64, Memo, Blob, Image'}
  // Extra types
  AnsiStringType = Nullable<AnsiString>;
  NativeIntType = Nullable<NativeInt>;
  Int64Type = Nullable<Int64>;

  // TODO:
  MemoType     = Nullable<TStringList>;
  BlobType     = Nullable<TStream>;
  ImageType    = Nullable<TStream>;
  {$ENDREGION}

  {$REGION 'Proxy<T>'}
  IProxy<T> = interface(DSharp.Core.Lazy.ILazy<T>)
    ['{A507D58C-8505-4498-A2D1-2DC7F6222A89}']
  end;

  TProxy<T> = class(DSharp.Core.Lazy.TLazy<T>, IProxy<T>)
  end;

  Proxy<T> = record
  strict private
    FProxy: IProxy<T>;
    function GetValue: T;
  public
    class constructor Create;

    class operator Implicit(const Value: Proxy<T>): IProxy<T>; overload;
    class operator Implicit(const Value: Proxy<T>): T; overload;
    class operator Implicit(const Value: TFunc<T>): Proxy<T>; overload;

    property Value: T read GetValue;
  end;
  {$ENDREGION}

  TFlushMode = (
    Always, // flushed before every query. This is almost always unnecessary and inefficient.
    Auto,   // default . sometimes flushed before query execution in order to ensure that queries never return stale state.
    Commit, // flushed when Transaction.commit() is called.
    Manual  // only ever flushed when Session.flush() is called. This mode is very efficient for read only transactions.
  );

  TIsolationLevel = (  // ReadUncommited = Concurrency..., ...Serializable = Consistency
    ReadUncommited,    // Dirty Reads, Non Reaptable Reads, Phantom Reads
    ReadCommited,      // Non Reaptable Reads, Phantom Reads
    RepeatableRead,    // Phantom Reads
    Serializable       // None
  );


  IDatabaseConnection = interface(IInterface)
    ['{17C11C80-4BC0-4FEB-93A4-10B30ABC778D}']
  end;

  ITransaction = interface(IInterface)
    ['{8C0D6805-68D5-407B-ADB1-277FA38DA21F}']
    function IsActive: Boolean;
    procedure BeginTransaction; overload;
    procedure BeginTransaction(IsolationLevel: TIsolationLevel); overload;
    procedure Commit;
    procedure RollBack;
  end;

  ICriteria<T> = interface
    ['{4CAE15E8-4BDD-4FD6-AC7F-E88C8E164635}']
  end;

  ISession = interface(IInterface)
    ['{2BDDDB63-1FDF-4CB0-865E-6FEBCE521A5E}']
    function BeginTransaction: ITransaction;
  end;

  ISessionFactory = interface(IInterface)
    ['{9D4AD94F-BB70-445E-89D4-44B6ED52D591}']
    function CreateSession: ISession;
  end;

  IMetadata = interface(IInterface)
    ['{6AEFD578-ABED-4487-9AD5-93502672D589}']
  end;

  IConfiguration = interface(IInterface)
    ['{71E5A779-6C2C-4BC1-BB6E-F299D66520A5}']
    function GetMetadata: IMetadata;
    property Metadata: IMetadata read GetMetadata;
  end;

  TSession = class(TComponent, ISession)
  private
    FConnection: IDatabaseConnection;
    FFlushMode: TFlushMode;
    FTransaction: ITransaction;
  public
    function Contains(Value: TObject): Boolean;
    function Delete(const SQL: string): Integer; overload;
    function Load<T: class; ValueType>(const ID: ValueType): T; overload;
    function Load<T: class>(const ID: string): T; overload;
    function Load<T: class>(ID: Integer): T; overload;
    function Load<T: class>: ICriteria<T>; overload;
    function LoadAll<T: class>: TObjectList<T>;
    function Merge<T: class>(Value: T): T;

    procedure Delete(Value: TObject); overload;
    // Remove this instance from the session cache.
    procedure Evict(Value: TObject);
    // Expression ??
    procedure Filter(Value: TObject; const Filter: string);
    // Refresh from database
    procedure Refresh(Value: TObject);
    procedure Save(Value: TObject);
    // Update the persistent instance with the identifier of the given transient instance.
    procedure Update(Value: TObject);
  public
    function BeginTransaction: ITransaction; overload;
    function BeginTransaction(IsolationLevel: TIsolationLevel): ITransaction; overload;

    procedure Clear;
    procedure Flush;

    property Connection: IDatabaseConnection read FConnection;
    property Transaction: ITransaction read FTransaction;
  published
    property FlushMode: TFlushMode read FFlushMode write FFlushMode;
  end;


implementation

uses
  Generics.Defaults,
  System.Rtti,
  System.Variants,
  DSharp.Core.Reflection;

{ TSession }

function TSession.BeginTransaction(IsolationLevel: TIsolationLevel): ITransaction;
begin

end;

function TSession.BeginTransaction: ITransaction;
begin

end;

procedure TSession.Clear;
begin

end;

function TSession.Contains(Value: TObject): Boolean;
begin
  // TODO: check cache
  Result := False;
end;

procedure TSession.Delete(Value: TObject);
begin

end;

function TSession.Delete(const SQL: string): Integer;
const
  NoneAffected = 0;
begin
  Result := NoneAffected;
end;

procedure TSession.Evict(Value: TObject);
begin

end;

procedure TSession.Filter(Value: TObject; const Filter: string);
begin

end;

procedure TSession.Flush;
begin

end;

function TSession.Load<T>: ICriteria<T>;
begin

end;

function TSession.Load<T, ValueType>(const ID: ValueType): T;
begin

end;

function TSession.LoadAll<T>: TObjectList<T>;
begin

end;

function TSession.Load<T>(ID: Integer): T;
begin
  Result := Load<T, Integer>(ID);
end;

function TSession.Merge<T>(Value: T): T;
begin

end;

procedure TSession.Refresh(Value: TObject);
begin

end;

function TSession.Load<T>(const ID: string): T;
begin
  Result := Load<T, string>(ID);
end;

procedure TSession.Save(Value: TObject);
begin

end;

procedure TSession.Update(Value: TObject);
begin

end;

{ Nullable<T> }

constructor Nullable<T>.Create(const Value: T);
begin
  FValue := Value;
  FHasValue := DefaultTrueBoolStr;
end;

constructor Nullable<T>.Create(const Value: Variant);
begin
  if not VarIsNull(Value) and not VarIsEmpty(Value) then
    Create(TValue.FromVariant(Value).AsType<T>)
  else
    Clear;
end;

procedure Nullable<T>.Clear;
begin
  FValue := Default(T);
  FHasValue := '';
end;

function Nullable<T>.Equals(const Value: Nullable<T>): Boolean;
begin
  if HasValue and Value.HasValue then
    Result := TEqualityComparer<T>.Default.Equals(Self.Value, Value.Value)
  else
    Result := HasValue = Value.HasValue;
end;

function Nullable<T>.GetHasValue: Boolean;
begin
  Result := FHasValue <> '';
end;

function Nullable<T>.GetValue: T;
begin
  if not HasValue then
    raise EInvalidOpException.CreateRes(@RNullableNoValue);
  Result := FValue;
end;

function Nullable<T>.GetValueOrDefault(const Default: T): T;
begin
  if HasValue then
    Result := FValue
  else
    Result := Default;
end;

function Nullable<T>.GetValueOrDefault: T;
begin
  Result := GetValueOrDefault(Default(T));
end;

class operator Nullable<T>.Implicit(const Value: Nullable<T>): T;
begin
  Result := Value.Value;
end;

class operator Nullable<T>.Implicit(const Value: Nullable<T>): Variant;
begin
  if Value.HasValue then
    Result := TValue.From<T>(Value.Value).AsVariant
  else
    Result := Null;
end;

class operator Nullable<T>.Implicit(const Value: Pointer): Nullable<T>;
begin
  if Value = nil then
    Result.Clear
  else
    Result := Nullable<T>.Create(T(Value^));
end;

class operator Nullable<T>.Implicit(const Value: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.Implicit(const Value: Variant): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.Equal(const Left, Right: Nullable<T>): Boolean;
begin
  Result := Left.Equals(Right);
end;

class operator Nullable<T>.NotEqual(const Left, Right: Nullable<T>): Boolean;
begin
  Result := not Left.Equals(Right);
end;

{ Proxy<T> }

class constructor Proxy<T>.Create;
begin
  GetRttiType(TypeInfo(T));
end;

function Proxy<T>.GetValue: T;
begin
  Result := FProxy();
end;

class operator Proxy<T>.Implicit(const Value: Proxy<T>): IProxy<T>;
begin
  Result := Value.FProxy;
end;

class operator Proxy<T>.Implicit(const Value: Proxy<T>): T;
begin
  Result := Value.Value;
end;

class operator Proxy<T>.Implicit(const Value: TFunc<T>): Proxy<T>;
begin
  Result.FProxy := TProxy<T>.Create(Value);
end;

end.
