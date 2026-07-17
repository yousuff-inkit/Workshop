<%@page import="com.workshop.evaluation.ClsEvaluationDAO" %>
<%  ClsEvaluationDAO DAO=new ClsEvaluationDAO(); %>    
<%
 String name = request.getParameter("name")==null?"":request.getParameter("name");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date = request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
  		
  		var data1= '<%= DAO.evlMainSearch(session,name,docno,date,id) %>';       
        
  		$(document).ready(function (){ 	
            var source =   
            {
                datatype: "json",
                datafields: [
                          	{name : 'refname' , type: 'String' },
     						{name : 'doc_no', type: 'String'  },
     						{name : 'voc_no', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						{name : 'billingamt', type: 'number'  },   
                 ],
               localdata: data1,
               
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
            $("#jqxEvlSearch").jqxGrid(
            {
            	width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
							{ text: 'Doc No.', datafield: 'voc_no', width: '20%' },
							{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },       
							{ text: 'Name', datafield: 'refname', width: '40%' },       
							{ text: 'Billing Amount', datafield: 'billingamt', width: '20%',cellsalign:'right',align:'right',cellsformat:'d2' },
							{ text: 'Doc No.', datafield: 'doc_no', width: '20%',hidden:true },
	              ]
            });
            
            $('#jqxEvlSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("masterdocno").value= $('#jqxEvlSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("docno").value= $('#jqxEvlSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");       
                $('#frmEvaluation select').attr('disabled', false);
                $('#date').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmEvaluation").submit();
                $('#frmEvaluation select').attr('disabled', true);
                $('#date').jqxDateTimeInput({disabled: true});        
                $('#window').jqxWindow('close');   
            }); 
        });
    </script>
    <div id="jqxEvlSearch"></div>
