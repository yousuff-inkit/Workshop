<%@page import="com.dashboard.audit.ageingverification.ClsAgeingVerificationDAO" %>
<% ClsAgeingVerificationDAO DAO = new ClsAgeingVerificationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%   String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
     String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
     String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 

<style type="text/css">
  .appliedClass
  {
     color: #0101DF;
  }
  .balanceClass
  {
	color: #FF0000;      
  }
  
</style>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		     data='<%=DAO.ageingVerificationGridLoading(rpttype, uptodate, atype, check)%>'; 
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'account', type: 'string' },
     						{name : 'name', type: 'string'   },
     						{name : 'accounting', type: 'number' },
     		     		    {name : 'ageing', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'tr_no', type: 'int'   },
     						{name : 'brhid', type: 'int'   }
	                      ],
                          localdata: data,
               
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
            $("#ageingVerificationGridID").jqxGrid(
            {
                width: '98%',
                height: 350,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							 }    
							},
							{ text: 'Account', datafield: 'account',  width: '10%' },			
							{ text: 'Account Name', datafield: 'name',  width: '40%' },	
							{ text: 'Accounting', datafield: 'accounting',  width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },	
							{ text: 'Ageing', datafield: 'ageing', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Balance', datafield: 'balance', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: 'balanceClass' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Tran No' , hidden: true, datafield: 'tr_no',  width: '5%' },
							{ text: 'Branch' , hidden: true, datafield: 'brhid',  width: '5%' },
						 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
            $('#ageingVerificationGridID').on('rowdoubleclick', function (event) { 
          	     var rowindex1=event.args.rowindex;   
          	     $("#ageingDifferenceGridID").jqxGrid({ disabled: false});
                 var indexVal =  $('#ageingVerificationGridID').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 var accountno =  $('#ageingVerificationGridID').jqxGrid('getcellvalue', rowindex1, "acno");
                 var rpttype="";
    			 if(indexVal>0){
    				if($('#cmbtype').val()==''){
    					 $.messager.alert('Message','Account Type is Mandatory.','warning');
    					 return 0;
    				}
    				document.getElementById("lblaccountno").innerText="Account : "+$('#ageingVerificationGridID').jqxGrid('getcellvalue', rowindex1, "account");
    				document.getElementById("lblaccountname").innerText=$('#ageingVerificationGridID').jqxGrid('getcellvalue', rowindex1, "name");
    				$('#btnRemoveApplying').attr('disabled',false);
    				if(document.getElementById("rdageing").checked==true){
    					rpttype="2";
    				} else {
    					rpttype="1";
    				}
    				$("#ageingDifferenceDiv").load("ageingDifferenceGrid.jsp?accountno="+accountno+'&atype='+$('#cmbtype').val()+'&rpttype='+rpttype+'&check=1');
    			 }
    			
             }); 

        });

</script>
<div id="ageingVerificationGridID"></div>
