<%@page import="com.dashboard.audit.ageingverification.ClsAgeingVerificationDAO" %>
<% ClsAgeingVerificationDAO DAO= new ClsAgeingVerificationDAO(); %>
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
	String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();
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
 
 		var data1 ='<%=DAO.ageingDifferenceGridLoading(atype,accountno,rpttype,check)%>';
 		
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
	                 			{name : 'transno', type: 'int' },
	     						{name : 'transtype', type: 'string'   },
	     						{name : 'date', type: 'date' },
	     						{name : 'description', type: 'string'   },
	     						{name : 'out_amount', type: 'number' },
	     		     		    {name : 'applied', type: 'number'   },
	     						{name : 'balance', type: 'number'   },
	     						{name : 'tranid', type: 'int'   },
	     						{name : 'acno', type: 'int'   },
	     						{name : 'id', type: 'int'   },
	     						{name : 'brhid', type: 'int'   },
	     						{name : 'currency', type: 'int'   }
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#ageingDifferenceGridID").jqxGrid({ 
            	width: '98%',
                height: 165,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype', editable: false, width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '7%' },	
							{ text: 'Remarks', datafield: 'description', editable: false, width: '44%' },	
							{ text: 'Applied(JV)', datafield: 'out_amount', width: '10%', cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right' },
							{ text: 'Applied', datafield: 'applied', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
							{ text: 'Balance', datafield: 'balance', width: '10%',cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'balanceClass' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Id' ,hidden: true, datafield: 'id',  width: '5%' },
							{ text: 'Branch', hidden: true, datafield: 'brhid',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
					]
            });
         
        });
                       
</script>
<div id="ageingDifferenceGridID"></div>