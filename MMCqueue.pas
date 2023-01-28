program MMCqueue;
{$apptype GUI}  
{$S-}
uses
  SimBase,
  SimBlocks,
  SimStdGUI;
  
type
  TMyModel = class(TModel)             //  Model declaration.  
    procedure Body; override;
  end;
                                     
var                                   
  Capacity,                            //  Model parameters.
  NumberOfServers: integer;             
  InterarrivalTime,                     
  ServiceTime: Double;                  
 
procedure TMyModel.Body;               //  Model description.
var                                    
  Gen: TGenerator;                     //  Blocks declaration.
  Que: TQueue;   
  Sel: TSelector;
begin 
  Gen:=TGenerator.Create([Capacity,ExpTime,InterarrivalTime]);
  Que:=TQueue.CreateDefault;
  Sel:=TSelector.Create([NumberOfServers]);
  Gen.Connect(Que);
  Que.Connect(Sel);
  Sel.Connect(1,NumberOfServers,TServer,[ExpTime,ServiceTime]); 
  
  Run(Gen);                            //  Launching the start block.
                                       
  Que.ShowStat;                        //  Results.  
end;

begin   
  Capacity:=3000;                      //  Initial values of the model.
  InterarrivalTime:=1;                 
  ServiceTime:=1.3;                    
  NumberOfServers:=2;                  

  Simulate(TMyModel,'The M/M/C queuing system');     //  Starting a model.
end.
