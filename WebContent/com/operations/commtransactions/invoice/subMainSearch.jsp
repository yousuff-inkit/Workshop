<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 	String client = request.getParameter("client")==null?"0":request.getParameter("client");
  String cmbagmttype = request.getParameter("cmbagmttype")==null?"0":request.getParameter("cmbagmttype");
  String agmtno = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
  String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
  String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
  String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
  ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();
 %> 
 <script type="text/javascript">
 
  var loaddata;

 loaddata='<%=invdao.mainSearch(client,cmbagmttype,agmtno,date,docno,branch)%>';
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         	{name : 'doc_no', type: 'String'  },
                         	{name : 'voucherno',type:'string'},
                        	{name :'rano',type:'string'},
                        	{name : 'voc_no',type:'string'},
                        	{name :'date',type:'date'},
                        	{name : 'agmttype',type:'string'},
     						{name : 'refname', type: 'String'  }
      					
      					
      						
      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                 height: 280, 
               /*  autoheight : true, */
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'MASTER DOC NO', datafield: 'doc_no', width: '20%',hidden:true },//Invoice Doc No
					{ text: 'DOC NO', datafield: 'voucherno', width: '20%' },//Invoice Voucher No
					{ text: 'AGMT NO', datafield: 'voc_no', width: '20%' },//Agreement Voucher No
					{ text:'ORIGINAL AGMT NO',datafield:'rano',width: '20%',hidden:true},//Agreement Doc No
					{ text: 'DATE', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
					{ text: 'AGMT TYPE', datafield: 'agmttype', width: '20%' }, 
					{ text: 'CLIENT', datafield: 'refname', width: '20%' }
					
					 
			
					
					
					]
            });
    
            $("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		var row2=event.args.rowindex;
				            	document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "doc_no");
				            	document.getElementById("voucherno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "voucherno");
				            	 $('#date').jqxDateTimeInput({ disabled: false});
				            	$("#date").jqxDateTimeInput('val', $("#jqxmainsearch").jqxGrid('getcellvalue', row2, "date")); 
				            	document.getElementById("agmtno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "rano");
				            	document.getElementById("agmtvoucherno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "voc_no");
				            	 $('#cmbagmttype').val($("#jqxmainsearch").jqxGrid('getcellvalue', row2, "agmttype")) ;
				            	$('#frmManualInvoice select').attr('disabled', false);
				        		$("#fromdate").jqxDateTimeInput({ disabled: false});
				                $("#todate").jqxDateTimeInput({ disabled: false}); 
				                funSetlabel();
				            	document.getElementById("frmManualInvoice").submit();
				                $('#window').jqxWindow('close');

				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
