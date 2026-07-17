<%@page import="com.operations.agreement.leaseagmt_alfahim.*"%>
<%ClsLeaseAgmtAlFahimDAO leasenew=new ClsLeaseAgmtAlFahimDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script>
var bankacnodata;
var id='<%=id%>';
if(id=="1"){
	bankacnodata='<%=leasenew.getBankAccount(id)%>';
}
else{
	bankacnodata=[];
}
$(document).ready(function(){
	
    var source =
    {
        datatype: "json",
        datafields: [                          	
                    	{name : 'doc_no', type: 'number'  },
						{name : 'account', type: 'string'    },
						{name : 'description', type: 'string'}
						
						
						
						
         ],               
         localdata: bankacnodata,
        
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
   
    
    
    $("#bankAccountGrid").jqxGrid(
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
                    							
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
					{ text: 'Account',datafield:'account',width:'30%'},
					{ text: 'Account Name', datafield: 'description', width: '70%'}					
          ]
    });
  
    $('#bankAccountGrid').on('rowdoubleclick', function (event) {
     	var rowindex=event.args.rowindex;
     	document.getElementById("pytbankacno").value=$('#bankAccountGrid').jqxGrid('getcellvalue',rowindex,'description');
     	document.getElementById("hidpytbankacno").value=$('#bankAccountGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
     	$('#bankacnowindow').jqxWindow('close');

         }); 
	
	       
});
</script>
<div id="bankAccountGrid"></div>
