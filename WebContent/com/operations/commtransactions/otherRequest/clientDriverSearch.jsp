<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>


<% String cldocno = request.getParameter("clientId")==null?"0":request.getParameter("clientId");
   String ratype = request.getParameter("raType")==null?"0":request.getParameter("raType");
   String rano = request.getParameter("raNo")==null?"0":request.getParameter("raNo"); %>

<script type="text/javascript">

	var data1;      
	$(document).ready(function () { 	
   
    var temp='<%=cldocno%>';
    
     if(temp>0){   
   	     data1='<%=cord.clientDriverSearch(cldocno,ratype,rano)%>';      
  	 }
       
		$(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'dr_id', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation', type: 'string'    },
     						{name : 'mobno', type: 'string'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'issdate', type: 'date'    },
     						{name : 'led', type: 'date'    },
     						{name : 'ltype', type: 'string'    },
     						{name : 'issfrm', type: 'string'    },
     						{name : 'passport_no', type: 'string' },
     						{name : 'pass_exp', type: 'date'    },
     						{name : 'visano', type: 'string'    },
     						{name : 'visa_exp', type: 'date'    },
     						{name : 'hiddob', type: 'string' },
     						{name : 'hidpassexp', type: 'string' },
     						{name : 'hidissdate', type: 'string' },
     						{name : 'hidled', type: 'string'    },
     						{name : 'hidvisaexp', type: 'string' },
     						{name : 'age', type: 'number'    },
     						{name : 'drage', type: 'number'    },
     						{name : 'licyr', type: 'number'    },
     						{name : 'expiryear', type: 'number'}
                        ],
                		
                        localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxclientdriverSearch").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              { text: 'clientid', datafield: 'codeno', width: '1%',hidden:true },
                              { text: 'cli drdoc', datafield: 'doc_no', width: '1%' ,hidden:true},
                              { text: 'cli drid', datafield: 'dr_id', width: '1%' ,hidden:true},
							{ text: 'Name', datafield: 'name', width: '15%' },
							{ text: 'Date of Birth', datafield: 'dob', cellsformat: 'dd.MM.yyyy',width: '10%' },
							{ text: 'Nationality', datafield: 'nation', width: '10%' },
							{ text: 'Mob No', datafield: 'mobno', width: '14%' },
							{ text: 'Licence#', datafield: 'dlno', width: '10%' },
							{ text: 'Lic Issued', datafield: 'issdate',cellsformat: 'dd.MM.yyyy', width: '9%' },
							{ text: 'Lic Expiry', datafield: 'led', width: '9%' , cellsformat: 'dd.MM.yyyy'},
							{ text: 'Lic Type', datafield: 'ltype', width: '12%',hidden:true },
							{ text: 'Iss From', datafield: 'issfrm', width: '9%' },
							{ text: 'Passport#', datafield: 'passport_no', width: '10%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp', width: '12%', cellsformat: 'dd.MM.yyyy',hidden:true },
							{ text: 'Visa No.', datafield: 'visano', width: '10%',hidden:true},
							{ text: 'Visa Exp.', datafield: 'visa_exp', width: '12%' ,hidden:true},
							{ text: 'Hid-Dob', datafield: 'hiddob', editable: false, hidden: true, width: '10%' },
							{ text: 'Hid-Pass-Exp', datafield: 'hidpassexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Iss-Date', datafield: 'hidissdate', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-LED', datafield: 'hidled', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Visa-Exp', datafield: 'hidvisaexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'age', datafield: 'age', width: '10%',hidden:true},
							{ text: 'licyr', datafield: 'licyr', width: '10%',hidden:true },
							{ text: 'expiryear', datafield: 'expiryear', width: '12%' ,hidden:true},
							{ text: 'licexp', datafield: 'licexp', width: '12%',hidden:true } 
	             
						]
            });
            
          $('#jqxclientdriverSearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                
                var rows = $("#jqxDriver").jqxGrid('getrows');
                for(var i=0 ; i < rows.length ; i++){
                var driverId=rows[i].dr_id;

                if(parseInt(driverId)==$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dr_id")){
                    document.getElementById("errormsg").innerText="Driver Already Selected.";  
                    return 0;
                 }
                }
                
                $("#jqxDriver").jqxGrid({ disabled: false});
                $("#jqxDriver").jqxGrid('addrow', null, {});
                var rows = $('#jqxDriver').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex1 = rowlength - 1;
            	
              /* var age=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "age");
              var drage=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "drage");
              var licyr=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "licyr");
              var expiryear=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "expiryear");
              var licexp=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "led");
              
             var today = new Date();
                   if(licexp<today){
                	   document.getElementById("errormsg").innerText=" Licence Expired";
                	   return false;
            	  } 
                     if(age<drage){
                    	
      					document.getElementById("errormsg").innerText=" Age Less than 25"; 	
           	      		return false;
              	    }
              
             
                    if(expiryear<licyr){
                    	document.getElementById("errormsg").innerText=" Issue Date Less Than One Year";
		       	         return false;
              	   }
		              else{
            	  		document.getElementById("errormsg").innerText="";	
        	   } */
            	
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "name" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "name"));
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "dob", $('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "dob"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "nation1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "nation"));
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "mobno" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "mobno"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "dlno" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dlno"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "ltype" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "ltype"));
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issfrm" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "issfrm"));
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issdate" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "issdate"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "led" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "led"));
              $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "passport_no" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "passport_no"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "pass_exp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "pass_exp"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "visano" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "visano"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "visa_exp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "visa_exp"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hiddob" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "hiddob"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidpassexp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "hidpassexp"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidissdate" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "hidissdate"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidled" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "hidled"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "hidvisaexp" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "hidvisaexp"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "doc_no" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $("#jqxDriver").jqxGrid('setcellvalue', rowindex1, "dr_id" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dr_id"));
              
              $('#driverDetailsWindow').jqxWindow('close'); 
            }); 
          
          
		});

});

</script>
<div id="jqxclientdriverSearch"></div>
 