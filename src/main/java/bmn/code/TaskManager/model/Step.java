package bmn.code.TaskManager.model;

import javax.persistence.*;

@Entity
@Table(name = "steps")
public class Step {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "step_id")
    private Long id;

    @Column(name = "step_name")
    private String stepName;

    public Step() {
    }

    public Step(String stepName) {
        this.stepName = stepName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStepName() {
        return stepName;
    }

    public void setStepName(String stepName) {
        this.stepName = stepName;
    }

}
