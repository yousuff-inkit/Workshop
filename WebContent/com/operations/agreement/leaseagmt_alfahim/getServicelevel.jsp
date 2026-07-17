<%@page import="com.operations.agreement.leaseagmt_alfahim.*"%>
<%ClsLeaseAgmtAlFahimDAO leasenew=new ClsLeaseAgmtAlFahimDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
String latype=request.getParameter("latype")==null?"":request.getParameter("latype");
String larefdocno=request.getParameter("larefdocno")==null?"":request.getParameter("larefdocno");
%>
<script>
var serviceleveldata;

var id='<%=id%>';
if(id=="1"){
	serviceleveldata='<%=leasenew.getServicelevel(id,latype,larefdocno)%>';
}
else{
	serviceleveldata=[];
}
$(document).ready(function(){
	
    var source =
    {
        datatype: "json",
        datafields: [                          	
                    	{name : 'doc_no', type: 'number'  },
						{name : 'name', type: 'string'    },
						{name : 'chkreplace', type: 'string'},
						{name : 'excessinsur',type:'string'}
						
						
						
         ],               
         localdata: serviceleveldata,
        
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
   
    
    
    $("#servicelevelGrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        altRows: true,
        selectionmode: 'singlerow',
     
                  
        
       
      /*   handlekeyboardnavigation: function (event) {
        	
            var cell1 = $('#jqxgrid2').jqxGrid('getselectedcell');
          alert(cell1);
            if (cell1 != undefined && cell1.datafield == 'name1') {
            	
                var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                alert("asss"+key);
                if (key == 114) {                                                      
                	driverinfoSearchContent('clientDriverSearch.jsp');
                 }
            } 
            
        }, 
        */
        
        columns: [
                    							
					{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
					{ text: 'Name',datafield:'name',width:'60%'},
					{ text: 'Replace Status', datafield: 'chkreplace', width: '30%'},
					{ text:'Excess Insur',datafield:'excessinsur',width:'30%',hidden:true}
          ]
    });
  
    $('#servicelevelGrid').on('rowdoubleclick', function (event) {
     	var rowindex=event.args.rowindex;
     	document.getElementById("servicelevel").value=$('#servicelevelGrid').jqxGrid('getcellvalue',rowindex,'name');
     	document.getElementById("hidservicelevel").value=$('#servicelevelGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
     	var excessinsur=$('#servicelevelGrid').jqxGrid('getcellvalue',rowindex,'excessinsur');
     	if(excessinsur!="0"){
     		$('#excessinsur').val($('#servicelevelGrid').jqxGrid('getcellvalue',rowindex,'excessinsur'));
     	}
     	$('#servicelevelwindow').jqxWindow('close');

         }); 
	
	       
});
</script>
<div id="servicelevelGrid"></div>
