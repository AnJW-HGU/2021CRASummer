'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class User extends Model {
        static associate(models) {
            // define association here
            this.hasMany(models.Post, {
                foreignkey: 'user_id'
            });
            this.hasMany(models.Comment, {
                foreignkey: 'user_id'
            });
            this.hasMany(models.Recomment, {
                foreignkey: 'user_id'
            });
            this.hasMany(models.Photo, {
                foreignkey: 'user_id'
            });
        }
    };

    User.init( {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.SMALLINT,
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
            type: DataTypes.SMALLINT,
            allowNull: false,
            defaultValue: 0
        },
        comments_count: {
            type: DataTypes.SMALLINT,
            allowNull: false,
            defaultValue: 0
        },
        reports_count: {
            type: DataTypes.SMALLINT,
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
            type: DataTypes.TINYINT,
            defaultValue: 0
        },
        resign_status:  {
            type: DataTypes.TINYINT,
            defaultValue: 0
        },
        singup_date:  {
            type: DataTypes.DATE,
            defaultValue: sequelize.NOW
        },
        resign_date:  {
            type: DataTypes.DATE,
            defaultValue: null
        },
    }, {
        sequelize,
        modelName: 'User',
        tableName: 'Users',
    });
  return User;
};
