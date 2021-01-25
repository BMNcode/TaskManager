<#import "parts/common.ftlh" as c>

<@c.page>

    <!--back in main-->
    <form action="/projectMainView" method="get">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-outline-secondary">Назад</button>
    </form>

    <!--add step-->
    <form class="row row-cols-md-auto g-1 align-items-center pt-5 pb-5" method="post" action="/addStep">
        <div class="col-3">
            <div class="input-group">
                <input type="text" class="form-control" name="stepName" placeholder="название шага" id="inlineFormInputGroupUsername">
            </div>
        </div>
        <div class="col-3">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-success btn-block">Добавить</button>
        </div>
    </form>

    <!--table list with steps-->
    <div class="col-12 pt-5">
        <table class="table">
            <#list editSteps as stps>
                <tbody>
                    <tr>
                        <td style="width: 70%">
                            <div class="textStepName">${stps.stepName}</div>
                            <form class="form-inline" method="post" action="/renameStep">
                                <input type="hidden" name="id" value="${stps.id}" />
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <div class="form-group">
                                        <input type="text" class="form-control editTextStepName"
                                        name="stepName" value="${stps.stepName}" />
                                    </div>
                                    <div class="form-group mx-sm-1">
                                        <button type="submit" rel="tooltip"
                                        class="btn btn-success btn-just-icon btn-sm saveTextStepName"
                                        data-original-title="" title="" name="save">
                                            <i class="material-icons">save</i>
                                        </button>
                                    </div>
                                    <div class="form-group">
                                        <button type="button" rel="tooltip"
                                            class="btn btn-danger btn-just-icon btn-sm cancelEditTextStepName"
                                            data-original-title="" title="">
                                                <i class="material-icons">clear</i>
                                        </button>
                                    </div>
                            </form>
                        </td>
                        <td class="td-actions text-right">
                            <form method="post" action="/deleteStep">
                                <input type="hidden" name="id" value="${stps.id}" />
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                     <button type="button" rel="tooltip"
                                        class="btn btn-success btn-just-icon btn-sm editButton"
                                        data-original-title="" title="">
                                            <i class="material-icons">edit</i>
                                     </button>
                                     <button type="submit" rel="tooltip"
                                        class="btn btn-danger btn-just-icon btn-sm"
                                        data-original-title="" title="">
                                            <i class="material-icons">delete</i>
                                     </button>
                            </form>
                        </td>
                    </tr>
                </tbody>
            <#else>
                <p class="text-center h1">No steps</p>
            </#list>
        </table>

</@c.page>