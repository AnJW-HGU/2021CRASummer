'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Users', {
      id: {
        primaryKey: true,
            autoIncrement: true,
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        google_id: {
            type: Sequelize.STRING(65),
            allowNull: false
        },
        student_id: {
            type: Sequelize.STRING(65),
            allowNull: false
        },
        name: {
            type: Sequelize.STRING(65),
            allowNull: false
        },
        email: {
            type: Sequelize.STRING(80),
            allowNull: false
        },
        nickname: {
            type: Sequelize.STRING(10),
            defaultValue: null
        },
        posts_count: {
            type: Sequelize.SMALLINT,
            allowNull: false,
            defaultValue: 0
        },
        comments_count: {
            type: Sequelize.SMALLINT,
            allowNull: false,
            defaultValue: 0
        },
        reports_count: {
            type: Sequelize.SMALLINT,
            allowNull: false,
            defaultValue: 0
        },
        points: {
            type: Sequelize.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        named_type:  {
            type: Sequelize.STRING(15),
            defaultValue: null
        },
        admin_status:  {
            type: Sequelize.TINYINT,
            defaultValue: 0
        },
        resign_status:  {
            type: Sequelize.TINYINT,
            defaultValue: 0
        },
        singup_date:  {
            type: Sequelize.DATE,
            defaultValue: Sequelize.NOW
        },
        resign_date:  {
            type: Sequelize.DATE,
            defaultValue: null
        },
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Users');
  }
};
                                             
