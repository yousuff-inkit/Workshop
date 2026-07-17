<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String docNo = request.getParameter("txtclientdocno2")==null?"0":request.getParameter("txtclientdocno2"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
        var data,datas;      
        $(document).ready(function () { 	
           
           var temp='<%=docNo%>';
            
             if(temp>0)
          	 {   
           	     data='<%=DAO.creditCardGridReloading(docNo,check)%>';      
          	 
          	 }else{
          		 
          		datas='<%=DAO.getCardType()%>';
          	 
          	 }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'type', type: 'string' },
     						{name : 'cardno', type: 'string' },
     						{name : 'exp_date', type: 'date' },
     						{name : 'remarks', type: 'string' },
     						{name : 'defaultcard', type: 'bool' },
     						{name : 'hidexpdate', type: 'string' }
                 ],
                 localdata: data,
                                        
            };
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            var list = datas.split(","); 
            	
            $("#jqxCreditCardDetails").jqxGrid(
            {
                width: '70%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxCreditCardDetails').jqxGrid('getrows');
                	var rowlength= rows.length;
                    var cell = $('#jqxCreditCardDetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'defaultcard' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
                            rowlength++; 
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
							{ text: 'Type', datafield: 'type', width: '15%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Card No.', datafield: 'cardno', width: '24%' },
                            { text: 'Exp-Date', datafield: 'exp_date', cellsformat: 'dd.MM.yyyy', columntype: 'datetimeinput', width: '13%',
                            	validation: function (cell, value) {
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          var year = value.getFullYear();
			                          if (year < cyear) {
			                        	  document.getElementById("chkcardvalid").value=1;
			                              return { result: false, message: "Card Expired." };
			                          }
			                          document.getElementById("chkcardvalid").value=0;
			                          return true;
								}	
                            },
                            { text: 'Remarks', datafield: 'remarks', width: '35%' },
                            { text: 'Default', datafield: 'defaultcard', columntype: 'checkbox', editable: true, checked: true, width: '8%',cellsalign: 'center', align: 'center' },
                            { text: 'Hid-Exp', datafield: 'hidexpdate', editable: false, hidden: true,  width: '10%' },
	              ]
            });
            
            //Add empty row
            if(temp==0){ 
       	      $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});  
            }
            
          if(temp>0){  
        	  $("#jqxCreditCardDetails").jqxGrid({ disabled: true});
       	  }
          
          $("#jqxCreditCardDetails").on('cellvaluechanged', function (event){
          	var datafield = event.args.datafield;
            var rowBoundIndex = event.args.rowindex;
  	        
			if(datafield=="exp_date"){
  	            var expdate = $('#jqxCreditCardDetails').jqxGrid('getcelltext', rowBoundIndex, "exp_date");
  	            $('#jqxCreditCardDetails').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",expdate);
  	         }
			 
			if(datafield=="cardno"){
	  	    	if(window.parent.cardnumbervalidator.value==1){
		            var cardno = $('#jqxCreditCardDetails').jqxGrid('getcelltext', rowBoundIndex, "cardno");
		            cardnumber(cardno);
	  	    	}
	         }
          });
          
          $("#jqxCreditCardDetails").bind('cellendedit', function (event) {
        	  var dataField = event.args.datafield;
        	  var rowIndex = event.args.rowindex;
        	  if(dataField=="defaultcard"){
	        	  if (event.args.value==true) {
	        	  
	        		  var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
	       				 for(var i=0 ; i < rows.length ; i++){
	       					 $('#jqxCreditCardDetails').jqxGrid('setcellvalue',i, "defaultcard","false");
	       				 }
	       			  $('#jqxCreditCardDetails').jqxGrid('setcellvalue',rowIndex, "defaultcard","true"); 
	        	  }
        	  }
        	});
       
});
        
</script>

<div id="jqxCreditCardDetails"></div>
<input type="hidden" id="chkcardvalid" name="chkcardvalid">