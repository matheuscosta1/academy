package br.com.tcc.project.command;

import br.com.portoseguro.payments.common.command.impl.AbstractCommand;
import br.com.portoseguro.payments.common.gateway.annotation.processor.GenerateCommandFactory;
import br.com.tcc.project.command.mongo.model.CollegeDocument;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@GenerateCommandFactory
public class FindAllDisciplinesByCollegeAndCourse extends AbstractCommand<FindAllDisciplinesByCollegeAndCourse.Request, List<CollegeDocument>> {

    @Setter
    @Getter
    @Builder
    public static class Request {
        private String collegeId;
        private String courseId;

    }
}
