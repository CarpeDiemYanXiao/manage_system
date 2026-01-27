<template>
    <div class="home-service-container">
        <!-- 主横幅 -->
        <div class="main-banner">
            <el-card shadow="never" class="transparent-card">
                <div class="banner-content">
                    <div class="banner-text">
                        <h1>专业家政服务平台</h1>
                        <p class="sub-title">安心 · 便捷 · 专业的家政服务解决方案</p>
                        <el-divider></el-divider>
                        <p class="banner-description">
                            提供保洁、月嫂、保姆、维修等全方位家政服务，
                            严格筛选服务人员，保障服务质量，让您的生活更轻松。
                        </p>
                    </div>
                </div>
            </el-card>
        </div>

        <!-- 核心服务 -->
        <div class="service-section">
            <h2 class="section-title"><i class="el-icon-service"></i> 我们的服务</h2>
            <el-row :gutter="30">
                <el-col :xs="24" :sm="12" :md="8" :lg="6">
                    <div class="service-card">
                        <div class="service-icon" style="color: #409EFF;">
                            <el-icon><House /></el-icon>
                        </div>
                        <h3>日常保洁</h3>
                        <p>专业保洁团队，提供日常家居清洁服务，让您的家焕然一新。</p>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="12" :md="8" :lg="6">
                    <div class="service-card">
                        <div class="service-icon" style="color: #67C23A;">
                            <el-icon><User /></el-icon>
                        </div>
                        <h3>月嫂服务</h3>
                        <p>专业月嫂提供新生儿、产妇护理等全方位服务。</p>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="12" :md="8" :lg="6">
                    <div class="service-card">
                        <div class="service-icon" style="color: #E6A23C;">
                            <el-icon><Setting /></el-icon>
                        </div>
                        <h3>家电维修</h3>
                        <p>专业维修师傅，快速解决各类家电故障问题。</p>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="12" :md="8" :lg="6">
                    <div class="service-card">
                        <div class="service-icon" style="color: #F56C6C;">
                            <el-icon><KnifeFork /></el-icon>
                        </div>
                        <h3>做饭阿姨</h3>
                        <p>专业厨师级阿姨，为您提供健康美味的家常菜。</p>
                    </div>
                </el-col>
            </el-row>
        </div>

        <!-- 服务优势 -->
        <div class="advantage-section">
            <h2 class="section-title"><i class="el-icon-medal"></i> 服务优势</h2>
            <el-row :gutter="20">
                <el-col :xs="12" :sm="8" :md="8" :lg="8">
                    <div class="advantage-card">
                        <div class="advantage-icon">
                            <el-icon><Finished /></el-icon>
                        </div>
                        <h4>严格筛选</h4>
                        <p>服务人员100%实名认证</p>
                    </div>
                </el-col>
                <el-col :xs="12" :sm="8" :md="8" :lg="8">
                    <div class="advantage-card">
                        <div class="advantage-icon">
                            <el-icon><Clock /></el-icon>
                        </div>
                        <h4>准时服务</h4>
                        <p>迟到30分钟免单</p>
                    </div>
                </el-col>
                <el-col :xs="12" :sm="8" :md="8" :lg="8">
                    <div class="advantage-card">
                        <div class="advantage-icon">
                            <el-icon><Wallet /></el-icon>
                        </div>
                        <h4>价格透明</h4>
                        <p>明码标价无隐形消费</p>
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script setup>
import {
    Clock,
    Finished,
    Headset,
    House,
    KnifeFork,
    Setting,
    User,
    Wallet
} from "@element-plus/icons-vue";
import { ref } from 'vue';

const value = ref(5);
</script>

<style lang="scss" scoped>
.home-service-container {
    padding: 20px;
    background-color: #f5f7fa;

    .transparent-card {
        background-color: transparent;
        border: none;
    }

    .main-banner {
        margin-bottom: 40px;

        .banner-content {
            display: flex;
            align-items: center;
            padding: 30px;
            background: linear-gradient(135deg, #5B86E5 0%, #36D1DC 100%);
            border-radius: 8px;
            color: white;

            .banner-text {
                flex: 1;
                padding-right: 40px;

                h1 {
                    font-size: 36px;
                    color: white;
                    margin-bottom: 15px;
                }

                .sub-title {
                    font-size: 18px;
                    color: rgba(255,255,255,0.8);
                    margin-bottom: 20px;
                }

                .banner-description {
                    font-size: 16px;
                    line-height: 1.8;
                    color: rgba(255,255,255,0.8);
                    margin-bottom: 30px;
                }

                .banner-actions {
                    display: flex;
                    gap: 20px;
                    margin-top: 30px;
                }
            }

            .banner-image {
                flex: 1;
                text-align: center;

                img {
                    max-width: 100%;
                    border-radius: 4px;
                    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
                }
            }
        }
    }

    .section-title {
        text-align: center;
        margin: 40px 0 30px;
        font-size: 28px;
        color: #303133;

        i {
            margin-right: 10px;
        }
    }

    .service-section {
        margin-bottom: 50px;

        .service-card {
            background: white;
            padding: 30px 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
            height: 100%;
            transition: transform 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;

            &:hover {
                transform: translateY(-5px);
            }

            .service-icon {
                font-size: 48px;
                margin-bottom: 20px;
            }

            h3 {
                font-size: 20px;
                margin-bottom: 15px;
                color: #303133;
            }

            p {
                color: #606266;
                line-height: 1.6;
                margin-bottom: 20px;
            }
        }
    }

    .advantage-section {
        margin: 50px 0;

        .advantage-card {
            background: white;
            padding: 25px 15px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
            height: 100%;
            margin-bottom: 20px;

            .advantage-icon {
                font-size: 36px;
                margin-bottom: 15px;
                color: #5B86E5;
            }

            h4 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #303133;
            }

            p {
                color: #909399;
                font-size: 14px;
            }
        }
    }

    .review-section {
        margin: 50px 0;

        .review-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            text-align: center;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            h4 {
                margin: 10px 0;
                color: #303133;
            }

            p {
                color: #606266;
                margin-top: 15px;
                font-style: italic;
            }
        }

        .el-carousel__item {
            padding: 10px;
        }
    }
}

@media (max-width: 768px) {
    .home-service-container {
        .main-banner {
            .banner-content {
                flex-direction: column;

                .banner-text {
                    padding-right: 0;
                    margin-bottom: 30px;
                }
            }
        }
    }
}
</style>
