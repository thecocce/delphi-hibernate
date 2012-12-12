unit DHibernate.Session;

interface

uses
  DHibernate.Transaction;

type
  ISession = interface(IInterface)
    ['{2BDDDB63-1FDF-4CB0-865E-6FEBCE521A5E}']
    function BeginTransaction: ITransaction;
  end;

  ISessionFactory = interface(IInterface)
    ['{9D4AD94F-BB70-445E-89D4-44B6ED52D591}']
    function CreateSession: ISession;
  end;

implementation

end.
