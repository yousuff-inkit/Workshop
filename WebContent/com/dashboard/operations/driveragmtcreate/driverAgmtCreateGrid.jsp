<%@page import="com.dashboard.operations.driveragmtcreate.*" %>
<%ClsDriverAgmtCreateDAO agmtdao=new ClsDriverAgmtCreateDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var drivergriddata;
var dataExcelExport;

var id='<%=id%>';
if(id=="1"){
	drivergriddata='<%=agmtdao.getGridData(branch,id)%>';
	dataExcelExport='<%=agmtdao.getGridDataexcel(branch,id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'    },
						/* {name : 'refno', type: 'string'  }, */
						{name : 'client', type: 'string'  },
						{name : 'branchname', type: 'string'  },
						{name : 'driver', type: 'string'  },
						{name : 'contracttype', type: 'string'  },
						{name : 'rate', type: 'number'  },
						{name : 'normalovertime',type:'number'},
						{name :'holidayovertime',type:'number'},
						{name :'fromdate',type:'date'},
						{name :'invtype',type:'string'},
						{name :'cldocno',type:'string'},
						{name : 'drvid',type:'string'},
						{name : 'brhid',type:'string'},
						{name : 'lpono',type:'string'},
						{name : 'overrate',type:'number'},
						{name : 'checkindate',type:'date'}
						],
				    localdata: drivergriddata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
  
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#driverAgmtCreateGrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:false,
        columns: [
               
						{ text: 'Doc No Original', datafield: 'doc_no', width: '4%' ,hidden:true},
						{ text: 'Doc No', datafield: 'voc_no', width: '8%'},
						{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Check In Date', datafield: 'checkindate', width: '8%',cellsformat:'dd.MM.yyyy'},
						/* { text: 'Ref No', datafield: 'refno', width: '8%',}, */
						{ text: 'Client', datafield: 'client', width: '17%'},
						{ text: 'Braanch Name', datafield: 'branchname', width: '17%'},
						{ text: 'Driver', datafield: 'driver', width: '16%'},
						{ text: 'Contract Type', datafield: 'contracttype', width: '8%'},
						{ text: 'Rate', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' },
						{ text: 'Normal Overtime/Hr', datafield: 'normalovertime', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Holiday Overtime/Hr', datafield: 'holidayovertime', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'From Date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Invoice Type', datafield: 'invtype', width: '8%'},
						{ text: 'Branch',datafield:'brhid',width:'10%',hidden:true},
						{ text: 'Client Id',datafield:'cldocno',width:'10%',hidden:true},
						{ text: 'Driver Id',datafield:'drvid',width:'10%',hidden:true},
						{ text: 'LPONO',datafield:'lpono',width:'10%',hidden:true},
						{ text: 'OVERRATE',datafield:'overrate',width:'10%',hidden:true}
					]

    });

	$('#driverAgmtCreateGrid').on('rowdoubleclick', function (event) 
			{ 
				var args = event.args;
				// row's bound index.
				var boundIndex = event.args.rowindex;
				// row's visible index.
				var visibleIndex = event.args.visibleindex;
				// right click.
				var rightclick = event.args.rightclick; 
				// original event.
				var ev = event.args.originalEvent;
				$('#docno').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				$('#cmbbranch').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				$('#date').jqxDateTimeInput('val',$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'date'));
				$('#client').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'client'));
				$('#hidclient').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
				$('#driver').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'driver'));
				$('#hiddriver').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'drvid'));
				$('#cmbcontracttype').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'contracttype'));
				$('#rate').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'rate'));
				$('#overrate').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'overrate'));
				$('#lpono').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'lpono'));
				$('#normalovertime').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'normalovertime'));
				$('#holidayovertime').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'holidayovertime'));
				$('#fromdate').jqxDateTimeInput('val',$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'fromdate'));
				$('#checkindate').jqxDateTimeInput('val',$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'checkindate'));
				var invoicetype=$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'invtype');
				if(invoicetype=="Monthly"){
					$('#cmbinvoicetype').val("1");
				}
				else{
					$('#cmbinvoicetype').val("2");
				}
	});
});

	
	
</script>
<div id="driverAgmtCreateGrid"></div>