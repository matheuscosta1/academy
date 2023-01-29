package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.RegisterCollege;
import br.com.tcc.project.command.discipline.mapper.RegisterCollegeMapper;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

@CommandReceiver(RegisterCollege.class)
public class RegisterCourseReceiver
    extends AbstractReceiver<RegisterCollege.Request, Void> {

  @Autowired @Setter private RegisterCollegeMapper registerCollegeMapper;

  @Autowired @Setter private MongoTemplate mongoTemplate;

  @Override
  protected Void doExecute(RegisterCollege.Request parameter) {
    mongoTemplate.save(registerCollegeMapper.map(parameter));
    return null;
  }
}
