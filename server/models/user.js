'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class User extends Model {
        static associate(models) {
            // define association here
            this.hasMany(models.Post, {
                foreignKey: 'user_id'
            });
            this.hasMany(models.Comment, {
                foreignKey: 'user_id'
            });
            this.hasMany(models.Recomment, {
                foreignKey: 'user_id'
            });
            this.hasMany(models.Photo, {
                foreignKey: 'user_id'
            });
			this.hasMany(models.Report, {
                foreignKey: 'user_id'
            });
			this.hasMany(models.Inquiry, {
                foreignKey: 'user_id'
			});
			this.hasMany(models.Notification, {
                foreignKey: 'user_id'
            });
			this.hasMany(models.Recommend, {
                foreignKey: 'user_id'
			});
			this.hasMany(models.Preferred_subject, {
				foreignKey: 'user_id'
            });
        }
    };
    User.init( {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
        },
        google_id: {
            type: DataTypes.STRING(65),
            allowNull: false
        },
        student_id: {
            type: DataTypes.STRING(65),
            allowNull: false
        },
        name: {
            type: DataTypes.STRING(65),
            allowNull: false
        },
        email: {
            type: DataTypes.STRING(80),
            allowNull: false
        },
        nickname: {
            type: DataTypes.STRING(10),
            defaultValue: null
        },
        posts_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        comments_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        reports_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        points: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        named_type:  {
            type: DataTypes.STRING(15),
            defaultValue: null
        },
        admin_status:  {
            type: DataTypes.INTEGER,
            defaultValue: 0
        },
        resign_status:  {
            type: DataTypes.INTEGER,
            defaultValue: 0
        },
    }, {
        sequelize,
        modelName: 'User',
        tableName: 'Users',
        createdAt: 'singup_date',
        updatedAt: 'resign_date',
    });
  return User;
};
