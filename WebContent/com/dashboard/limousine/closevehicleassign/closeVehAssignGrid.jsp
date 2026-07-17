<%@page import="com.dashboard.limousine.closevehassign.*" %>
<%ClsCloseVehAssignDAO assigndao=new ClsCloseVehAssignDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String id=request.getParameter("id")==null?"0":request.getParameter("id");

%>
<style type="text/css">
  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">
var assigndata;
var CloseVehexcel;
var id='<%=id%>';
if(id=="1"){
	assigndata='<%=assigndao.getCloseAssignData(branch, id)%>';
        CloseVehexcel='<%=assigndao.excelCloseAssignData(branch, id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
						{name : 'fleet_no', type: 'string'  },
						{name : 'reg_no', type: 'int'  },
						{name : 'platecode', type: 'string'  },
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name: 'fleetinfo',type: 'string'},
						{name : 'assignno',type:'string'},
						{name : 'outdate',type:'date'},
						{name : 'outtime',type:'string'},
						{name : 'outkm',type:'number'},
						{name :'outfuel',type:'string'},
						{name : 'movdocno',type:'string'},
						{name : 'driver',type:'string'}
							],
				    localdata: assigndata,
        
        
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
    
 
    
    $("#closeVehAssignGrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						
						{ text: 'Fleet No.', datafield: 'fleet_no',width: '8%'},
						{ text: 'Reg No', datafield: 'reg_no',width: '8%' },
						{ text: 'Plate Code', datafield: 'platecode', width: '8%' },
						{ text: 'Brand', datafield: 'brand',width:'12%'},
						{ text: 'Model', datafield: 'model' ,width:'12%'},
						{ text: 'Assign No',datafield:'assignno',hidden:true},
						{ text: 'Driver',datafield:'driver',width:'20%'},
						{ text: 'Out Date',datafield:'outdate',cellsformat:'dd.MM.yyyy',width:'8%'},
						{ text: 'Out Time',datafield:'outtime',width:'8%'},
						{ text: 'Out KM',datafield:'outkm',cellsformat:'d2',width:'8%'},
						{ text: 'Out Fuel',datafield:'outfuel',width:'8%'},
						{ text: 'Mov Docno',datafield:'movdocno',hidden:true}
							]
    
    });
    

	     $('#closeVehAssignGrid').on('rowdoubleclick', function (event) {
         	var rowindex1=event.args.rowindex;
         	funreadonly("2");
         	document.getElementById('fleetno').value=$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'fleet_no');
	     	var details="";
	     	details+='Reg No     : '+$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'reg_no');
	     	details+='';
	     	document.getElementById("fleetdetails").innerText=details;
	     	document.getElementById("assignno").value=$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'assignno');
	     	$('#outdate').jqxDateTimeInput('val',$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'outdate'));
	     	$('#outtime').jqxDateTimeInput('val',$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'outtime'));
	     	document.getElementById("outkm").value=$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'outkm');
	     	document.getElementById("outfuel").value=$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'outfuel');
	     	document.getElementById("movdocno").value=$('#closeVehAssignGrid').jqxGrid('getcellvalue',rowindex1,'movdocno');
	     });
});

	
	
</script>
<div id="closeVehAssignGrid"></div>