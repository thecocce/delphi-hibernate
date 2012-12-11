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

type
{$SCOPEDENUMS ON}
  TReleaseMode = (
    AfterTransaction,
    OnClose
  );
{$SCOPEDENUMS OFF}

  // TODO -oCesar: use DHibernate.Session.ISessionFactory
  ISessionFactory = interface
    ['{62B831E1-61D7-4633-8FD2-F17CC6963D50}']
  end;

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

  // TODO -oCesar: finish implementation
  TConfiguration = class(TInterfacedObject, IConfiguration)
  private
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
  protected
    const
      DefaultFetchDepth = 3;
  public
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

function TConfiguration.GetCacheProviderClass: TClass;
begin
  Result := nil;
end;

function TConfiguration.GetConnectionString: string;
begin
  Result := '';
end;

function TConfiguration.GetDialectClass: TClass;
begin
  Result := nil;
end;

function TConfiguration.GetMaxFetchDepth: Integer;
begin
  Result := DefaultFetchDepth;
end;

function TConfiguration.GetProviderClass: TClass;
begin
  Result := nil;
end;

function TConfiguration.GetReleaseMode: TReleaseMode;
begin
  Result := TReleaseMode.OnClose;
end;

function TConfiguration.GetSchema: string;
begin
  Result := '';
end;

function TConfiguration.GetShowSql: Boolean;
begin
  Result := False;
end;

function TConfiguration.GetTransactionFactoryClass: TClass;
begin
  Result := nil;
end;

procedure TConfiguration.LoadFromFile(const FileName: string);
begin

end;

procedure TConfiguration.SetCacheProviderClass(const Value: TClass);
begin

end;

procedure TConfiguration.SetConnectionString(const Value: string);
begin

end;

procedure TConfiguration.SetDialectClass(const Value: TClass);
begin

end;

procedure TConfiguration.SetMaxFetchDepth(const Value: Integer);
begin

end;

procedure TConfiguration.SetProviderClass(const Value: TClass);
begin

end;

procedure TConfiguration.SetReleaseMode(const Value: TReleaseMode);
begin

end;

procedure TConfiguration.SetSchema(const Value: string);
begin

end;

procedure TConfiguration.SetShowSql(const Value: Boolean);
begin

end;

procedure TConfiguration.SetTransactionFactoryClass(const Value: TClass);
begin

end;

end.
