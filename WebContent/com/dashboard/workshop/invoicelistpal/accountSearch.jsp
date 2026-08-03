<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

    <script type="text/javascript">
    $(document).ready(function () {
        // Initialization if needed
    }); 

    function loadSearch() {
        var type = document.getElementById("cmbaccounttype").value;
        var clientsname = document.getElementById("txtclientsname").value;
        var docno = document.getElementById("txtdocno").value;
        
        getAccountData(clientsname, docno, type);
    }
    
    function getAccountData(clientsname, docno, type){
        // Upgraded to use encodeURIComponent for safe parameter passing
        var url = 'accountSearchGrid.jsp' + 
                  '?type=' + encodeURIComponent(type) + 
                  '&clientname=' + encodeURIComponent(clientsname) + 
                  '&docno=' + encodeURIComponent(docno) + 
                  '&id=1';
                  
        $('#accountsearchgriddiv').load(url);
    }
    </script>

<style>
*{
    box-sizing:border-box;
}

html,body{
    margin:0;
    padding:0;
    width:100%;
    max-width:100%;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
    overflow-x:hidden;
}

#search{
    padding:10px;
    background:#fff;
    width:100%;
    max-width:100%;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
    width:100%;
    max-width:100%;
    display:flex;
    flex-wrap:wrap;
    align-items:flex-end;
    gap:10px 14px;
}

.field-group{
    display:flex;
    flex-direction:column;
    flex:1 1 140px;
    min-width:110px;
    max-width:100%;
}

.field-group.grow-2{
    flex:2 1 200px;
}

.lbl-right{
    text-align:left;
    font-size:12px;
    font-weight:500;
    color:#333;
    margin-bottom:4px;
    white-space:nowrap;
}

.search-input{
    height:26px;
    width:100%;
    max-width:100%;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
    background-color: #fff;
    color: #333;
    outline: none;
}

.search-input:focus { 
    border-color: #007bff; 
}

.btn-group{
    flex:0 0 auto;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
    width:100%;
    max-width:100%;
}
</style>
</head>
<body>

<div id="search">

    <div class="search-panel">
        
        <div class="field-group">
            <span class="lbl-right">Account #</span>
            <input type="text"
                   id="txtdocno"
                   name="txtdocno"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtdocno"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Account Name</span>
            <input type="text"
                   id="txtclientsname"
                   name="txtclientsname"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtclientsname"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Type</span>
            <select name="cmbaccounttype" 
                    id="cmbaccounttype" 
                    class="search-input">
                <option value="">--Select--</option>
                <option value="1">Client</option>
                <option value="2">Insur.Company</option>
            </select>
        </div>

        <div class="btn-group">
            <input
                type="button"
                id="btnsearch"
                name="btnsearch"
                class="myButton"
                onclick="loadSearch();"
                value="Search"
                style="
                    width:100px;
                    height:28px;
                    background:#205fd3;
                    color:#fff;
                    border:1px solid #205fd3;
                    border-radius:4px;
                    font-size:12px;
                    font-weight:600;
                    cursor:pointer;">
        </div>

    </div>

    <div class="grid-container">
        <div id="accountsearchgriddiv">
           <jsp:include page="accountSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>