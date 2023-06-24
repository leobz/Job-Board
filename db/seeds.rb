# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

#***************************     Admin user   ****************************
env_file =
  File.join(Rails.root, 'config', 'local_env.yml')
    YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
  end if File.exists?(env_file)

admin = User.new(email: "admin@admin.com", password: ENV["ADMIN_PASSWORD"])
admin.save

#***************************        Jobs     ****************************

def attach_company_logo(job, file_path)
  f = File.open(file_path)
  logo_blob = ActiveStorage::Blob.create_and_upload!(io: f, filename: 'logo.png', content_type: 'image/png')
  job.company_logo.attach(logo_blob)
end

if Job.count == 0
  j = Job.new(
    title: "Lead Concept Artist (Retro Studios)",
    description:"Founded in 1998, Retro Studios is a wholly owned subsidiary of Nintendo Company, Ltd.  Retro is a state-of-the-art game development studio, working in conjunction with Nintendo to bring award-winning games to Nintendo's cutting-edge next-generation platforms.  Retro Studios is located in beautiful Austin, Texas. With rolling hills, scenic waterways, abundant wildlife, vibrant music and film scenes, and a laid-back cosmopolitan culture, Austin is a dynamic city with an excellent quality of life.  Austin's sunny weather also supports a great range of outdoor activities, providing plenty of venues for top-notch game developers to recharge and unwind.\r\n\r\nAnnounced by Nintendo in January 2019, Retro Studios is currently in the midst of developing Metroid Prime 4 for the Nintendo Switch.\r\n\r\n\r\nDESCRIPTION OF DUTIES\r\n\r\n- Collaborates with the Art Director, Artists, and Designers to define the look of our projects by working to establish a consistent visual direction for characters, environments, props, effects and mood using all art tools available.\r\n- Adopts a broad range of styles from realistic to highly stylized based on goals and direction for a given project to produce concept art with an appropriate sense of color, drama, shape language, personality, and design.\r\n- Takes ownership of concept work for various characters, environments, and props while actively collaborating with other disciplines such as Design, Art, and Engineering in order to achieve high-quality, innovative concept art\r\n- Creates character, environment, and prop concept art in the form of thumbnails, sketches, breakdowns, reference sheets, paintings, and other digital imagery\r\n- Designs visually cohesive fictional worlds and characters\r\n- Provides technical and aesthetic breakdowns of concept art to support art, design and engineering efforts\r\n- Generates visual contextualization support for gameplay design efforts at all stages\r\n- Works with Art Director, and Leads to provide feedback and guidance to Artists\r\n- Creates storyboards, background illustrations, and promotional artwork\r\n- Provides and receives feedback professionally\r\n- Identifies and implements best practices, workflows and pipelines that pushes the quality bar for concept art.\r\n- Communicates directly with Producers to coordinate Concept Art resources for both internal and external artists, establishing schedules, tracking task and priorities.\r\n- Handles performance evaluations, bonus reviews, and any necessary disciplinary plans for direct reports\r\n- Responsible for having 1-1 meetings to understand career goals for individuals in group\r\n- *This job description outlines primary duties and requirements and is not intended to identify all tasks that may be performed; individuals occupying the position may be required to perform other duties.  The company may modify job duties from time to time, either in practice or in writing.\r\n\r\nSUMMARY OF REQUIREMENTS\r\n\r\n- Has eight or more years' industry experience as a concept artist, including at least two complete product cycles\r\n- Excellent 2D drawing skills with a strong grasp of composition, color theory, perspective, lighting, environment, and architecture\r\n- Mastery of fundamental artistic principles\r\n- Online portfolio with high-quality examples of character and environment concept art\r\n- Experience executing a wide range of artistic styles\r\n- Demonstrated ability to develop visual representations of abstract ideas\r\n- 3D art skills, including modeling, sculpting, material creation and lighting is a big plus\r\n- Experience with Shotgrid, Jira or other task tracking software is a big plus.\r\n- Good communicator, self-motivated, driven to grow professionally\r\n- Undergraduate degree in art-related subject, completion of an intensive art training program, or equivalent experience",
    website: "https://careers.nintendo.com/job-openings/apply/?id=220000006X&src=CWS-10000&loc=retro",
    company: "Nintendo",
    location: "Austin, TX",
    location_mode: "REMOTE",
    salary: 70000,
    created_at: "Thu, 27 Apr 2023 12:00:00 UTC +00:00",
    published: true
  )
  attach_company_logo(j, Rails.root.join("app/assets/images/company_logos/nintendo.jpg"))
  j.save
end