<%@page import="com.dashboard.operations.driveragmtprocess.*" %>
<%ClsDriverAgmtProcessDAO agmtdao=new ClsDriverAgmtProcessDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%>
<script type="text/javascript">
var drivergriddata;
var id='<%=id%>';
if(id=="1"){
	drivergriddata='<%=agmtdao.getGridData(branch,id,date,type)%>'; 
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
						{name : 'driver', type: 'string'  },
						{name : 'contracttype', type: 'string'  },
						{name : 'rate', type: 'number'  },
						{name : 'normalovertime',type:'number'},
						{name :'holidayovertime',type:'number'},
						{name :'fromdate',type:'date'},
						{name :'invdate',type:'date'},
						{name :'invtodate',type:'date'},
						{name :'invtype',type:'string'},
						{name :'cldocno',type:'string'},
						{name : 'drvid',type:'string'},
						{name : 'brhid',type:'string'}
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
    
    
    $("#driverAgmtProcessGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
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
						{ text: 'Doc No', datafield: 'voc_no', width: '4%'},
						{ text: 'Contract dt.', datafield: 'fromdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						/* { text: 'Ref No', datafield: 'refno', width: '8%',}, */
						{ text: 'Client', datafield: 'client', width: '16%'},
						{ text: 'Driver', datafield: 'driver', width: '16%'},
						{ text: 'Contract Type', datafield: 'contracttype', width: '8%'},
						{ text: 'Rate', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' },
						{ text: 'Normal Overtime/Hr', datafield: 'normalovertime', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Holiday Overtime/Hr', datafield: 'holidayovertime', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Last Process Date', datafield: 'invdate', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Process To Date', datafield: 'invtodate', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Invoice Type', datafield: 'invtype', width: '7%'},
						{ text: 'Branch',datafield:'brhid',width:'10%',hidden:true},
						{ text: 'Client Id',datafield:'cldocno',width:'10%',hidden:true},
						{ text: 'Driver Id',datafield:'drvid',width:'10%',hidden:true}
					]

    });

	$('#driverAgmtProcessGrid').on('rowdoubleclick', function (event) 
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
				$('#agmtno,#docno,#hidclient,#normalovertime,#holidayovertime,#totalrate,#totalnormalovertime,#totalholidayovertime').val('');
				$('#uptodate').jqxDateTimeInput('val',new Date());
				$('#closedate').jqxDateTimeInput('val',new Date());
				$('#agmtno').val($('#driverAgmtProcessGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				$('#docno').val($('#driverAgmtProcessGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				$('#cmbbranch').val($('#driverAgmtProcessGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				$('#hidclient').val($('#driverAgmtProcessGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
				
	});
});

	
	
</script>
<div id="driverAgmtProcessGrid"></div>