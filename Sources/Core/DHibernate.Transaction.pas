unit DHibernate.Transaction;

interface

type
  ///	<summary>
  ///	  <para>
  ///	    ReadUncommited = Concurrency...,
  ///	  </para>
  ///	  <para>
  ///	    ...Serializable = Consistency
  ///	  </para>
  ///	</summary>
  TIsolationLevel = (
    ///	<summary>
    ///	  Dirty Reads, Non Reaptable Reads, Phantom Reads
    ///	</summary>
    ReadUncommited,

    ///	<summary>
    ///	  Non Reaptable Reads, Phantom Reads
    ///	</summary>
    ReadCommited,

    ///	<summary>
    ///	  Phantom Read
    ///	</summary>
    RepeatableRead,

    ///	<summary>
    ///	  None
    ///	</summary>
    Serializable
  );

  ITransaction = interface(IInterface)
    ['{8C0D6805-68D5-407B-ADB1-277FA38DA21F}']
    function IsActive: Boolean;
    procedure BeginTransaction; overload;
    procedure BeginTransaction(IsolationLevel: TIsolationLevel); overload;
    procedure Commit;
    procedure RollBack;
  end;

implementation

end.
