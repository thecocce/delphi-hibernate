unit DHibernate.Configuration;

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
  DHibernate.Session;

type
{$SCOPEDENUMS ON}
  TReleaseMode = (
    AfterTransaction,
    OnClose
  );
{$SCOPEDENUMS OFF}

  IConfiguration = interface
    ['{BFA516EB-A183-4BCB-B59B-F425DB896CBD}']
    {$REGION 'Access methods'}
      function GetCacheProviderClass: TClass;
      function GetConnectionString: string;
      function GetDialectClass: TClass;
      function GetMaxFetchDepth: Integer;
      function GetProviderClass: TClass;
      function GetReleaseMode: TReleaseMode;
      function GetSchema: string;
      function GetShowSql: Boolean;
      function GetTransactionFactoryClass: TClass;
      procedure SetCacheProviderClass(const Value: TClass);
      procedure SetConnectionString(const Value: string);
      procedure SetDialectClass(const Value: TClass);
      procedure SetMaxFetchDepth(const Value: Integer);
      procedure SetProviderClass(const Value: TClass);
      procedure SetReleaseMode(const Value: TReleaseMode);
      procedure SetSchema(const Value: string);
      procedure SetShowSql(const Value: Boolean);
      procedure SetTransactionFactoryClass(const Value: TClass);
    {$ENDREGION}

    function BuildSessionFactory: ISessionFactory;
    procedure LoadFromFile(const FileName: string);

    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property MaxFetchDepth: Integer read GetMaxFetchDepth write SetMaxFetchDepth;
    property ReleaseMode: TReleaseMode read GetReleaseMode write SetReleaseMode;
    property Schema: string read GetSchema write SetSchema;
    property ShowSql: Boolean read GetShowSql write SetShowSql;

    property CacheProviderClass: TClass read GetCacheProviderClass write SetCacheProviderClass;
    property DialectClass: TClass read GetDialectClass write SetDialectClass;
    property ProviderClass: TClass read GetProviderClass write SetProviderClass;
    property TransactionFactoryClass: TClass read GetTransactionFactoryClass write SetTransactionFactoryClass;
  end;

  TConfiguration = class(TInterfacedObject, IConfiguration)
  private
    {$REGION 'Access methods'}
      FCacheProviderClass: TClass;
      FConnectionString: string;
      FDialectClass: TClass;
      FMaxFetchDepth: Integer;
      FProviderClass: TClass;
      FReleaseMode: TReleaseMode;
      FSchema: string;
      FShowSql: Boolean;
      FTransactionFactoryClass: TClass;
      function GetCacheProviderClass: TClass;
      function GetConnectionString: string;
      function GetDialectClass: TClass;
      function GetMaxFetchDepth: Integer;
      function GetProviderClass: TClass;
      function GetReleaseMode: TReleaseMode;
      function GetSchema: string;
      function GetShowSql: Boolean;
      function GetTransactionFactoryClass: TClass;
      procedure SetCacheProviderClass(const Value: TClass);
      procedure SetConnectionString(const Value: string);
      procedure SetDialectClass(const Value: TClass);
      procedure SetMaxFetchDepth(const Value: Integer);
      procedure SetProviderClass(const Value: TClass);
      procedure SetReleaseMode(const Value: TReleaseMode);
      procedure SetSchema(const Value: string);
      procedure SetShowSql(const Value: Boolean);
      procedure SetTransactionFactoryClass(const Value: TClass);
    {$ENDREGION}
  protected
    const
      DefaultFetchDepth = 3;

    procedure ParseConnectionString(const Value: string);
  public
    constructor Create;

    function BuildSessionFactory: ISessionFactory;
    procedure LoadFromFile(const FileName: string);

    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property MaxFetchDepth: Integer read GetMaxFetchDepth write SetMaxFetchDepth;
    property ReleaseMode: TReleaseMode read GetReleaseMode write SetReleaseMode;
    property Schema: string read GetSchema write SetSchema;
    property ShowSql: Boolean read GetShowSql write SetShowSql;

    property CacheProviderClass: TClass read GetCacheProviderClass write SetCacheProviderClass;
    property DialectClass: TClass read GetDialectClass write SetDialectClass;
    property ProviderClass: TClass read GetProviderClass write SetProviderClass;
    property TransactionFactoryClass: TClass read GetTransactionFactoryClass write SetTransactionFactoryClass;
  end;

implementation

{ TConfiguration }

function TConfiguration.BuildSessionFactory: ISessionFactory;
begin
  Result := nil;
end;

constructor TConfiguration.Create;
begin
  inherited Create;

  FMaxFetchDepth := DefaultFetchDepth;
  FReleaseMode := TReleaseMode.OnClose;
end;

function TConfiguration.GetCacheProviderClass: TClass;
begin
  Result := FCacheProviderClass;
end;

function TConfiguration.GetConnectionString: string;
begin
  Result := FConnectionString;
end;

function TConfiguration.GetDialectClass: TClass;
begin
  Result := FDialectClass;
end;

function TConfiguration.GetMaxFetchDepth: Integer;
begin
  Result := FMaxFetchDepth;
end;

function TConfiguration.GetProviderClass: TClass;
begin
  Result := FProviderClass;
end;

function TConfiguration.GetReleaseMode: TReleaseMode;
begin
  Result := FReleaseMode;
end;

function TConfiguration.GetSchema: string;
begin
  Result := FSchema;
end;

function TConfiguration.GetShowSql: Boolean;
begin
  Result := FShowSql;
end;

function TConfiguration.GetTransactionFactoryClass: TClass;
begin
  Result := FTransactionFactoryClass;
end;

procedure TConfiguration.LoadFromFile(const FileName: string);
begin
  // TODO -o Cesar: implement
end;

procedure TConfiguration.ParseConnectionString(const Value: string);
begin
  // TODO -o Cesar : implement - raise exception if not valid
end;

procedure TConfiguration.SetCacheProviderClass(const Value: TClass);
begin
  FCacheProviderClass := Value;
end;

procedure TConfiguration.SetConnectionString(const Value: string);
begin
  ParseConnectionString(Value);
  FConnectionString := Value;
end;

procedure TConfiguration.SetDialectClass(const Value: TClass);
begin
  FDialectClass := Value;
end;

procedure TConfiguration.SetMaxFetchDepth(const Value: Integer);
begin
  FMaxFetchDepth := Value;
end;

procedure TConfiguration.SetProviderClass(const Value: TClass);
begin
  FProviderClass := Value;
end;

procedure TConfiguration.SetReleaseMode(const Value: TReleaseMode);
begin
  FReleaseMode := Value;
end;

procedure TConfiguration.SetSchema(const Value: string);
begin
  FSchema := Value;
end;

procedure TConfiguration.SetShowSql(const Value: Boolean);
begin
  FShowSql := Value;
end;

procedure TConfiguration.SetTransactionFactoryClass(const Value: TClass);
begin
  FTransactionFactoryClass := Value;
end;

end.
