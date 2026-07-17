<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtotherrequestdocno2")==null?"0":request.getParameter("txtotherrequestdocno2");%> 
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0){   
            	  data1='<%=cord.otherRequestGridReloading(docNo,session)%>';    
           	 }
                                
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'type', type: 'string' }, 
     						{name : 'remarks', type: 'string' },
     						{name : 'amount', type: 'number' },
     						{name : 'typeid', type: 'string' }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxOtherRequest").jqxGrid(
            {
                width: '98%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    
                  //Search Pop-Up
                    var cell1 = $('#jqxOtherRequest').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'type') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	document.getElementById("rowindex1").value = cell1.rowindex;
                        	$('#jqxOtherRequest').jqxGrid('render');
                        	serviceSearchContent('extraServiceRequestGridSearch.jsp');
                        }
                    }
                },
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
                            { text: 'Extra Service Request Description', datafield: 'type', width: '20%',editable:false },
                            { text: 'Remarks', datafield: 'remarks', width: '60%' },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
							{ text: 'Service Id', datafield: 'typeid', hidden:true, width: '10%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#jqxOtherRequest").jqxGrid('addrow', null, {});
          	 }
         	  
            if(temp>0){
            	$("#jqxOtherRequest").jqxGrid('disabled', true);
            }
            
         	  $("#jqxOtherRequest").on('cellvaluechanged', function (event) 
         	  {
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
         		if(datafield=="type"){
         			$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindexestemp, "remarks" ,'');	
         			$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindexestemp, "amount" ,'');
      	     	  }
                });
         	  
         	 $('#jqxOtherRequest').on('celldoubleclick', function (event) {
             	  if(event.args.columnindex == 1){
             	    	var rowindextemp = event.args.rowindex;
             	        document.getElementById("rowindex1").value = rowindextemp;
             	        $('#jqxOtherRequest').jqxGrid('clearselection');
             	        serviceSearchContent('extraServiceRequestGridSearch.jsp');
             		  }
             	  
             	 if(event.args.columnindex == 0){
          	    	var rowindextemp = event.args.rowindex;
          	    	$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindextemp, "type" ,'');	
          	    	$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindextemp, "remarks" ,'');	
         			$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindextemp, "total" ,'');
         			$('#jqxOtherRequest').jqxGrid('setcellvalue', rowindextemp, "typeid" ,'');
          		  }
             	  
              }); 
         	  
          
    });
</script>
<div id="jqxOtherRequest"></div>
    
 <input type="hidden" id="rowindex1"/> 