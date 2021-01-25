package bmn.code.TaskManager.model;


import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "project_comments")
public class ProjectComment {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private Project project;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "comment_id")
    private Long commentId;

    @Column(name = "comment")
    private String comment;

    @Column(name = "status_comment")
    private Boolean statusComment;

    public ProjectComment() {
    }

    public ProjectComment(String comment) {
        this.comment = comment;
    }

    public ProjectComment(String comment, Boolean statusComment) {
        this.comment = comment;
        this.statusComment = statusComment;
    }

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public Boolean getStatusComment() {
        return statusComment;
    }

    public void setStatusComment(Boolean statusComment) {
        this.statusComment = statusComment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProjectComment that = (ProjectComment) o;
        return Objects.equals(commentId, that.commentId) &&
                Objects.equals(comment, that.comment);
    }

    @Override
    public int hashCode() {
        return Objects.hash(commentId, comment);
    }

    @Override
    public String toString() {
        return "ProjectComment{" +
                "project=" + project +
                ", commentId=" + commentId +
                ", comment='" + comment + '\'' +
                ", statusComment=" + statusComment +
                '}';
    }
}
