package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.FindAllCollege;
import br.com.tcc.project.command.FindDisciplineByCode;
import br.com.tcc.project.command.mongo.model.CollegeDocument;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@CommandReceiver(FindAllCollege.class)
public class FindAllCollegeReceiver
    extends AbstractReceiver<FindAllCollege.Request, List<CollegeDocument> > {

  @Autowired @Setter private MongoTemplate mongoTemplate;

  @Override
  protected List<CollegeDocument> doExecute(FindAllCollege.Request parameter) {

    return mongoTemplate.findAll(CollegeDocument.class);
  }
}
