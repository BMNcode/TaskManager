<#import "parts/common.ftlh" as c>

<@c.page>
    <!--back in main-->
    <div class="pb-5">
        <form action="/projectMainView" method="get">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-outline-secondary">Назад</button>
        </form>
    </div>

    <!--header-->
    <p class="text-center align-middle h1">
        ${project.numberProject?ifExists}
        ${project.nameProject?ifExists}
        ${project.revision?ifExists}
        <button type="button" rel="tooltip"
            class="btn btn-outline-secondary btn-just-icon btn-sm"
            style="border: 0 !important;"
            data-toggle="collapse"
            data-target="#hide">
                <i class="material-icons">edit</i>
        </button>
    </p>
    <!--edit project-->
    <div class="collapse pb-3" id="hide">
        <form class="row row-cols-md-auto g-1 align-items-center pt-5" method="post" action="/renameProject">
            <div class="col-3">
                <div class="input-group">
                    <input type="text" class="form-control"
                        value="${project.numberProject?ifExists}"
                            name="numberProject" placeholder="номер проекта"
                                id="inlineFormInputGroupUsername">
                </div>
                </div>
            <div class="col-3">
                <div class="input-group">
                    <input type="text" class="form-control"
                        value="${project.nameProject?ifExists}"
                            name="nameProject" placeholder="название проекта"
                                id="inlineFormInputGroupUsername">
                </div>
            </div>
            <div class="col-3">
                <div class="input-group">
                    <input type="text" class="form-control"
                        value="${project.revision?ifExists}"
                            name="revision" placeholder="ревизия"
                                id="inlineFormInputGroupUsername">
                </div>
            </div>
            <div class="col-3">
                <input type="hidden" name="projectId" value="${project.projectId}" />
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <button type="submit" class="btn btn-warning btn-block">Редактировать</button>
            </div>
        </form>
    </div>

    <!--lists steps-->
    <ul class="list-group pt-5">
        <#list step as stp>
            <#if stp.statusStep == "in progress...">
                <form method="get" action="/steps" id="form-step-id">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <input type="hidden" name="id" value="${stp.id}" />
                    <a href="#" class="list-group-item list-group-item-action list-group-item-secondary" onclick="document.getElementById('form-step-id').submit();">
                        ${stp.stepName?ifExists}
                    </a>
                </form>
            <#else>
                <li class="list-group-item list-group-item-success">
                    ${stp.stepName?ifExists}
                </li>
            </#if>
        <#else>
            <p class="text-center h1">No steps</p>
        </#list>
    </ul>

    <!--add comments-->
    <form method="post" action="/addComment">
        <textarea class="form-control mt-4" aria-label="With textarea" name="comment"></textarea>
        <button class="btn btn-primary mt-2 mb-5 btn-block" type="submit">Добавить комментарий</button>
        <input type="hidden" name="projectId" value="${project.projectId}" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>

    <!--comments cards-->
    <div class="card-columns ml-5">
        <#list projectComments as comments>
            <form method="post" action="/closeComment" >
                <#if comments.statusComment == false>
                    <div class="card text-center text-white bg-secondary cardsComment" style="width: 18rem;">
                        <div class="card-body">
                            <p class="card-text">${comments.comment}</p>
                            <input type="hidden" name="commentId" value="${comments.commentId}" />
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button class="btn btn-primary" type="submit">Закрыть</button>
                        </div>
                    </div>
                <#else>
                    <div class="card text-center text-white bg-success cardsComment" style="width: 18rem;">
                        <div class="card-body">
                            <p class="card-text">${comments.comment}</p>
                        </div>
                    </div>
                </#if>
            </form>
        </#list>
    </div>

</@c.page>