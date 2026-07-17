
<%@page import="com.limousine.limoinvoice.*" %>
<%
ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String name=request.getParameter("name")==null?"":request.getParameter("name");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String mail=request.getParameter("mail")==null?"":request.getParameter("mail");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>

 <script type="text/javascript">
        
 var clientsearchdata;
 var id='<%=id%>';
	if(id=="1"){
		clientsearchdata='<%=invoicedao.getClientSearchData(docno, name, mobile, mail, date, id)%>';
	}
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'cldocno',type:'string'},
     						{name : 'refname', type: 'string'  },
     						{name : 'address', type: 'string'    },
     						{name : 'mobile',type:'number'},
     						{name : 'mail',type:'string'},
     						{name : 'date',type:'date'}

                 ],               
               localdata:clientsearchdata,
               
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

            
            
            $("#clientSearchGrid").jqxGrid(
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
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            	}
                            },
                            {text: 'Doc No',datafield:'cldocno',width:'10%'},					
                            { text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Name', datafield: 'refname', width: '45%'},
							{ text: 'Mobile', datafield: 'mobile', width: '15%' },
							{ text: 'Mail', datafield: 'mail', width: '15%'}
	              ]
            });
       $('#clientSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
				return false;
			}
			
    	   document.getElementById("client").value=$('#clientSearchGrid').jqxGrid('getcellvalue',row1,'refname');
    	   document.getElementById("hidclient").value=$('#clientSearchGrid').jqxGrid('getcellvalue',row1,'cldocno');
    	   var details="";
    	   details+="Address: "+$('#clientSearchGrid').jqxGrid('getcellvalue',row1,'address')+",";
    	   details+=" Mobile: "+$('#clientSearchGrid').jqxGrid('getcellvalue',row1,'mobile')+",";
    	   details+=" Mail: "+$('#clientSearchGrid').jqxGrid('getcellvalue',row1,'mail');
    	   document.getElementById("clientdetails").value=details;
    	   $('#clientwindow').jqxWindow('close');
		});
       
        });
    </script>
    <div id="clientSearchGrid"></div>
