
<%@page import="com.limousine.limoinvoice.*" %>
<%
ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String clientmob=request.getParameter("clientmob")==null?"":request.getParameter("clientmob");
String chkallbranch=request.getParameter("chkallbranch")==null?"":request.getParameter("chkallbranch");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>

 <script type="text/javascript">
        
 var searchdata;
 var id='<%=id%>';
	if(id=="1"){
		searchdata='<%=invoicedao.getSearchData(docno, client, clientmob, date,chkallbranch, id,branch)%>';
	}
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'doc_no',type:'int'},
     						{name : 'voc_no', type: 'string'  },
     						{name : 'date', type: 'date'    },
     						{name : 'fromdate',type:'date'},
     						{name : 'todate',type:'date'},
     						{name : 'cldocno',type:'string'},
     						{name : 'refname',type:'string'},
     						{name : 'address',type:'string'},
     						{name : 'mail1',type:'string'},
     						{name : 'per_mob',type:'string'},
     						{name : 'ledgernote',type:'string'},
     						{name : 'invoicenote',type:'string'}

                 ],               
               localdata:searchdata,
               
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

            
            
            $("#searchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                selectionmode: 'singlerow',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
 
				},
                
                columns: [
                            
                            {text: 'Original Doc No',datafield:'doc_no',width:'10%',hidden:true},
                            {text: 'Doc No',datafield:'voc_no',width:'10%',},
                            { text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
                            { text: 'From Date',datafield:'fromdate',width:'10%',cellsformat:'dd.MM.yyyy',hidden:true},
                            { text: 'To Date',datafield:'todate',width:'10%',cellsformat:'dd.MM.yyyy',hidden:true},
                            { text: 'Client Doc',datafield:'cldocno',width:'10%',hidden:true},
							{ text: 'Client', datafield: 'refname', width: '65%'},
							{ text: 'Mobile', datafield: 'per_mob', width: '15%' },
							{ text: 'Mail', datafield: 'mail1', width: '15%',hidden:true},
							{ text: 'Address',datafield:'address',width:'10%',hidden:true},
							{ text: 'Ledger Note',datafield:'ledgernote',hidden:true},
							{ text: 'Invoice Note',datafield:'invoicenote',hidden:true}
	              ]
            });
       $('#searchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   document.getElementById("docno").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'doc_no');
    	   document.getElementById("vocno").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'voc_no');
    	   document.getElementById("hidclient").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'cldocno');
    	   document.getElementById("client").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'refname');
    	   var details="";
    	   details+="Address: "+$('#searchGrid').jqxGrid('getcellvalue',row1,'address')+",";
    	   details+=" Mobile: "+$('#searchGrid').jqxGrid('getcellvalue',row1,'per_mob')+",";
    	   details+=" Mail: "+$('#searchGrid').jqxGrid('getcellvalue',row1,'mail1');
    	   document.getElementById("clientdetails").value=details;
    	   $('#date').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',row1,'date'));
    	   $('#fromdate').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',row1,'fromdate'));
    	   $('#todate').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',row1,'todate'));
    	   document.getElementById("ledgernote").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'ledgernote');
    	   document.getElementById("invoicenote").value=$('#searchGrid').jqxGrid('getcellvalue',row1,'invoicenote');
    	   setValues();
    	   $('#window').jqxWindow('close');
		});
       
        });
    </script>
    <div id="searchGrid"></div>
