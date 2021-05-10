clearvars Rastr;

global Rastr;
global RTable_Node;
global RTable_Branch;
global size_node;
global size_branch;

Rastr = actxserver('Astra.Rastr');
shabl = 'C:\Users\inspiron\Documents\RastrWin3\SHABLON\режим.rg2';

filename = 'C:\Универ\Диплом\14 узлов\14uzlov1.rg2';
Rastr.Load( 1, filename, shabl );

RTables = Rastr.Tables;
RTable_Node = RTables.Item('node');
RTable_Branch = RTables.Item('vetv');
size_node = RTable_Node.get('size');
size_branch = RTable_Branch.get('size');